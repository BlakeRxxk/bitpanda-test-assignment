import Combine
import Foundation

// MARK: - ViewModel

@MainActor
public final class ViewModel<R: Reducer> {

    // MARK: Lifecycle

    public init(
        reducer: @Sendable @autoclosure () -> R,
        state: State) {
        initialState = state
        self.state = state
        store = Store(
            reducer: reducer(),
            state: state)
        let (stream, continuation) = AsyncStream<State>.makeStream()
        states = ViewStateStream(stream)
        self.continuation = continuation
        task = Task { [weak self] in
            guard let states = await self?.store.states else { return }
            for await state in states {
                guard let self else { break }
                guard !Task.isCancelled else { break }
                self.state = state
            }
        }
    }

    deinit {
        task?.cancel()
        continuation.finish()
    }

    // MARK: Public

    public typealias Action = R.Action where R.Action: Sendable
    public typealias State = R.State where R.State: Sendable & Equatable

    public let initialState: State

    public let states: ViewStateStream<State>

    public var state: State {
        didSet {
            onStateChange()
        }
    }

    public func send(_ action: Action) {
        Task { await store.send(action) }
    }

    public func reset() {
        Task { await store.reset() }
    }

    // MARK: Private

    private let store: Store<R>
    private let continuation: AsyncStream<State>.Continuation
    private var task: Task<Void, Never>?

    private func onStateChange() {
        continuation.yield(state)
        states.send(state)
        objectWillChange.send()
    }
}

// MARK: ObservableObject

extension ViewModel: ObservableObject { }
