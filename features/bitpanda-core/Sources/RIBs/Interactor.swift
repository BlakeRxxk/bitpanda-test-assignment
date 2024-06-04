//
//  Interactor.swift
//  BitPandaCore
//

import Combine

// MARK: - InteractorScope

public protocol InteractorScope: AnyObject {

    // The following properties must be declared in the base protocol, since `Router` internally invokes these methods.
    // In order to unit test router with a mock interactor, the mocked interactor first needs to conform to the custom
    // subclass interactor protocol, and also this base protocol to allow the `Router` implementation to execute base
    // class logic without error.

    /// Indicates if the interactor is active.
    var isActive: Bool { get }

    /// The lifecycle of this interactor.
    ///
    /// - note: Subscription to this stream always immediately returns the last event. This stream terminates after
    ///   the interactor is deallocated.
    var isActiveStream: AnyPublisher<Bool, Never> { get }
}

// MARK: - Interactable

/// The base protocol for all interactors.
public protocol Interactable: InteractorScope {

    // The following methods must be declared in the base protocol, since `Router` internally invokes these methods.
    // In order to unit test router with a mock interactor, the mocked interactor first needs to conform to the custom
    // subclass interactor protocol, and also this base protocol to allow the `Router` implementation to execute base
    // class logic without error.

    /// Activate this interactor.
    ///
    /// - note: This method is internally invoked by the corresponding router. Application code should never explicitly
    ///   invoke this method.
    func activate()

    /// Deactivate this interactor.
    ///
    /// - note: This method is internally invoked by the corresponding router. Application code should never explicitly
    ///   invoke this method.
    func deactivate()
}

// MARK: - Interactor

/// An `Interactor` defines a unit of business logic that corresponds to a router unit.
///
/// An `Interactor` has a lifecycle driven by its owner router. When the corresponding router is attached to its
/// parent, its interactor becomes active. And when the router is detached from its parent, its `Interactor` resigns
/// active.
///
/// An `Interactor` should only perform its business logic when it's currently active.
open class Interactor: Interactable {

    // MARK: Lifecycle

    /// Initializer.
    public init() {
        // No-op
    }

    deinit {
        if isActive {
            deactivate()
        }
        isActiveSubject.send(completion: .finished)
    }

    // MARK: Open

    /// The interactor did become active.
    ///
    /// - note: This method is driven by the attachment of this interactor's owner router. Subclasses should override
    ///   this method to setup subscriptions and initial states.
    open func didBecomeActive() {
        // No-op
    }

    /// Called when the `Interactor` will resign the active state.
    ///
    /// This method is driven by the detachment of this interactor's owner router. Subclasses should override this
    /// method to cleanup any resources and states of the `Interactor`. The default implementation does nothing.
    open func willResignActive() {
        // No-op
    }

    // MARK: Public

    /// Indicates if the interactor is active.
    public final var isActive: Bool {
        isActiveSubject.value
    }

    /// A stream notifying on the lifecycle of this interactor.
    public final var isActiveStream: AnyPublisher<Bool, Never> {
        isActiveSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    /// Activate the `Interactor`.
    ///
    /// - note: This method is internally invoked by the corresponding router. Application code should never explicitly
    ///   invoke this method.
    public final func activate() {
        guard !isActive else { return }

        activenessCancellable = []

        isActiveSubject.send(true)

        didBecomeActive()
    }

    /// Deactivate this `Interactor`.
    ///
    /// - note: This method is internally invoked by the corresponding router. Application code should never explicitly
    ///   invoke this method.
    public final func deactivate() {
        guard isActive else { return }

        willResignActive()

        activenessCancellable?.forEach {
            $0.cancel()
        }
        activenessCancellable = nil

        isActiveSubject.send(false)
    }

    // MARK: Fileprivate

    fileprivate var activenessCancellable: Set<AnyCancellable>?

    // MARK: Private

    private let isActiveSubject = CurrentValueSubject<Bool, Never>(false)
}
