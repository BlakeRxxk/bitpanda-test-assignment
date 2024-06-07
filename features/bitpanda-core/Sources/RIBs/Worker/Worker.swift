//
//  Worker.swift
//  BitPandaCore
//

import Combine

// MARK: - Working

/// The base protocol of all workers that perform a self-contained piece of logic.
///
/// `Worker`s are always bound to an `Interactor`. A `Worker` can only start if its bound `Interactor` is active.
/// It is stopped when its bound interactor is deactivated.
public protocol Working: AnyObject {

    /// Starts the `Worker`.
    ///
    /// If the bound `InteractorScope` is active, this method starts the `Worker` immediately. Otherwise the `Worker`
    /// will start when its bound `Interactor` scope becomes active.
    ///
    /// - parameter interactorScope: The interactor scope this worker is bound to.
    func start(_ scope: InteractorScope)

    /// Stops the worker.
    ///
    /// Unlike `start`, this method always stops the worker immediately.
    func stop()

    /// Indicates if the worker is currently started.
    var isStarted: Bool { get }

    /// The lifecycle of this worker.
    ///
    /// Subscription to this stream always immediately returns the last event. This stream terminates after the
    /// `Worker` is deallocated.
    var isStartedPublisher: AnyPublisher<Bool, Never> { get }
}

// MARK: - Worker

/// The base `Worker` implementation.
open class Worker: Working {

    // MARK: Lifecycle

    /// Initializer.
    public init() {
        // No-op
    }

    deinit {
        stop()
        unbindInteractor()
        isStartedSubject.send(completion: .finished)
    }

    // MARK: Open

    /// Called when the the worker has started.
    ///
    /// Subclasses should override this method and implment any logic that they would want to execute when the `Worker`
    /// starts. The default implementation does nothing.
    ///
    /// - parameter interactorScope: The interactor scope this `Worker` is bound to.
    open func didStart(_: InteractorScope) {

    }

    /// Called when the worker has stopped.
    ///
    /// Subclasses should override this method abnd implement any cleanup logic that they might want to execute when
    /// the `Worker` stops. The default implementation does noting.
    ///
    /// - note: All subscriptions added to the disposable provided in the `didStart` method are automatically disposed
    /// when the worker stops.
    open func didStop() {
        // No-op
    }

    // MARK: Public

    /// Indicates if the `Worker` is started.
    public final var isStarted: Bool {
        isStartedSubject.value
    }

    /// The lifecycle stream of this `Worker`.
    public final var isStartedPublisher: AnyPublisher<Bool, Never> {
        isStartedSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    public final func start(_ scope: InteractorScope) {
        guard !isStarted else {
            return
        }

        stop()

        isStartedSubject.send(true)

        // Create a separate scope struct to avoid passing the given scope instance, since usually
        // the given instance is the interactor itself. If the interactor holds onto the worker without
        // de-referencing it when it becomes inactive, there will be a retain cycle.
        let weakInteractorScope = WeakInteractorScope(scope: scope)
        bind(to: weakInteractorScope)
    }

    /// Stops the worker.
    ///
    /// Unlike `start`, this method always stops the worker immediately.
    public final func stop() {
        guard isStarted else {
            return
        }

        isStartedSubject.send(false)

        executeStop()
    }

    // MARK: Fileprivate

    fileprivate var cancellable: Set<AnyCancellable>?

    // MARK: Private

    private let isStartedSubject = CurrentValueSubject<Bool, Never>(false)
    private var interactorBindingCancellable: Cancellable?

    private func bind(to scope: InteractorScope) {
        unbindInteractor()

        interactorBindingCancellable = scope.isActiveStream
            .sink(receiveValue: { [weak self] (isInteractorActive: Bool) in
                if isInteractorActive {
                    if self?.isStarted == true {
                        self?.executeStart(scope)
                    }
                } else {
                    self?.executeStop()
                }
            })
    }

    private func executeStart(_ scope: InteractorScope) {
        cancellable = []
        didStart(scope)
    }

    private func executeStop() {
        guard let cancellable = cancellable else { return }

        cancellable.forEach { $0.cancel() }
        self.cancellable = nil

        didStop()
    }

    private func unbindInteractor() {
        interactorBindingCancellable?.cancel()
        interactorBindingCancellable = nil
    }
}

// MARK: - WeakInteractorScope

private class WeakInteractorScope: InteractorScope {

    // MARK: Lifecycle

    fileprivate init(scope: InteractorScope) {
        sourceScope = scope
    }

    // MARK: Internal

    weak var sourceScope: InteractorScope?

    var isActive: Bool {
        sourceScope?.isActive ?? false
    }

    var isActiveStream: AnyPublisher<Bool, Never> {
        sourceScope?.isActiveStream ?? Just(false).eraseToAnyPublisher()
    }

}
