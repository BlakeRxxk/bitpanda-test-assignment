import Foundation

public actor Store<R: Reducer> {

    // MARK: Lifecycle

    public init(
        reducer: @Sendable @autoclosure () -> R,
        state: State) {
        initialState = state
        self.state = state
        self.reducer = reducer()
        (states, continuation) = AsyncStream<State>.makeStream()
        Task { await bindExternalEffect() }
        defer { continuation.yield(state) }
    }

    deinit {
        tasks.forEach { $0.value.cancel() }
        bindingTask?.cancel()
    }

    // MARK: Public

    public typealias Action = R.Action where R.Action: Sendable
    public typealias State = R.State where R.State: Sendable & Equatable

    public let initialState: State

    public var states: AsyncStream<State>

    public var state: State {
        didSet {
            guard oldValue != state else { return }
            continuation.yield(state)
        }
    }

    public func send(_ action: Action) async {
        actionQueue.append(action)

        guard !isProcessing else { return }
        isProcessing = true

        while !actionQueue.isEmpty {
            let action = actionQueue.removeFirst()
            let uuid = UUID()
            let effect = reducer.reduce(state: &state, action: action)

            let task = Task { [weak self, uuid] in
                for await value in effect.values {
                    guard let self, !Task.isCancelled else { break }
                    await send(value)
                }
                await self?.remove(by: uuid)
            }

            tasks[uuid] = task
        }

        isProcessing = false
    }

    public func reset() {
        bindExternalEffect()
        tasks.forEach { $0.value.cancel() }
        tasks.removeAll()
        actionQueue.removeAll()
    }

    // MARK: Private

    private let reducer: any Reducer<Action, State>
    private let continuation: AsyncStream<State>.Continuation
    private var isProcessing = false
    private var actionQueue: [Action] = []
    private var bindingTask: Task<Void, Never>?
    private var tasks: [UUID: Task<Void, Never>] = [:]

    private func bindExternalEffect() {
        bindingTask?.cancel()

        bindingTask = Task { [weak self] in
            guard let self, !Task.isCancelled else { return }
            for await value in reducer.bind().values {
                await send(value)
            }
        }
    }

    private func remove(by key: UUID) {
        guard let task = tasks.removeValue(forKey: key) else { return }

        task.cancel()
    }
}
