//
//  Router.swift
//  BitPandaCore
//

import Combine

// MARK: - RouterLifecycle

/// The lifecycle stages of a router scope.
public enum RouterLifecycle {

    /// Router did load.
    case didLoad
}

// MARK: - RouterScope

/// The scope of a `Router`, defining various lifecycles of a `Router`.
public protocol RouterScope: AnyObject {

    /// An observable that emits values when the router scope reaches its corresponding life-cycle stages. This
    /// observable completes when the router scope is deallocated.
    var lifecycle: AnyPublisher<RouterLifecycle, Never> { get }
}

// MARK: - Routing

/// The base protocol for all routers.
public protocol Routing: RouterScope {

    // The following methods must be declared in the base protocol, since `Router` internally  invokes these methods.
    // In order to unit test router with a mock child router, the mocked child router first needs to conform to the
    // custom subclass routing protocol, and also this base protocol to allow the `Router` implementation to execute
    // base class logic without error.

    /// The base interactable associated with this `Router`.
    var interactable: Interactable { get }

    /// The list of children routers of this `Router`.
    var children: [Routing] { get }

    /// Loads the `Router`.
    ///
    /// - note: This method is internally used by the framework. Application code should never
    ///   invoke this method explicitly.
    func load()

    // We cannot declare the attach/detach child methods to take in concrete `Router` instances,
    // since during unit testing, we need to use mocked child routers.

    /// Attaches the given router as a child.
    ///
    /// - parameter child: The child router to attach.
    func attach(child: Routing)

    /// Detaches the given router from the tree.
    ///
    /// - parameter child: The child router to detach.
    func detach(child: Routing)
}

// MARK: - Router

/// The base class of all routers that does not own view controllers, representing application states.
///
/// A router acts on inputs from its corresponding interactor, to manipulate application state, forming a tree of
/// routers. A router may obtain a view controller through constructor injection to manipulate view controller tree.
/// The DI structure guarantees that the injected view controller must be from one of this router's ancestors.
/// Router drives the lifecycle of its owned `Interactor`.
///
/// Routers should always use helper builders to instantiate children routers.
open class Router<InteractorType>: Routing {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter interactor: The corresponding `Interactor` of this `Router`.
    public init(interactor: InteractorType) {
        self.interactor = interactor
        guard let interactable = interactor as? Interactable else {
            fatalError("\(interactor) should conform to \(Interactable.self)")
        }
        self.interactable = interactable
    }

    deinit {
        interactable.deactivate()

        if !children.isEmpty {
            detachAllChildren()
        }

        lifecycleSubject.send(completion: .finished)

        cancellables.forEach { $0.cancel() }
        LeakDetector.instance.expectDeallocate(object: interactable)
    }

    // MARK: Open

    /// Called when the router has finished loading.
    ///
    /// This method is invoked only once. Subclasses should override this method to perform one time setup logic,
    /// such as attaching immutable children. The default implementation does nothing.
    open func didLoad() {
        // No-op
    }

    // MARK: Public

    /// The corresponding `Interactor` owned by this `Router`.
    public let interactor: InteractorType

    /// The base `Interactable` associated with this `Router`.
    public let interactable: Interactable

    /// The list of children `Router`s of this `Router`.
    public final var children: [Routing] = []

    /// The observable that emits values when the router scope reaches its corresponding life-cycle stages.
    ///
    /// This observable completes when the router scope is deallocated.
    public final var lifecycle: AnyPublisher<RouterLifecycle, Never> {
        lifecycleSubject.eraseToAnyPublisher()
    }

    /// Loads the `Router`.
    ///
    /// - note: This method is internally used by the framework. Application code should never invoke this method
    ///   explicitly.
    public final func load() {
        guard !didLoadFlag else {
            return
        }

        didLoadFlag = true
        internalDidLoad()
        didLoad()
    }

    // We cannot declare the attach/detach child methods to take in concrete `Router` instances,
    // since during unit testing, we need to use mocked child routers.

    /// Attaches the given router as a child.
    ///
    /// - parameter child: The child `Router` to attach.
    public final func attach(child: Routing) {
        assert(!(children.contains { $0 === child }), "Attempt to attach child: \(child), which is already attached to \(self).")

        children.append(child)

        // Activate child first before loading. Router usually attaches immutable children in didLoad.
        // We need to make sure the RIB is activated before letting it attach immutable children.
        child.interactable.activate()
        child.load()
    }

    /// Detaches the given `Router` from the tree.
    ///
    /// - parameter child: The child `Router` to detach.
    public final func detach(child: Routing) {
        child.interactable.deactivate()

        children.removeElementByReference(child)
    }

    // MARK: Internal

    var cancellables: Set<AnyCancellable> = []

    func internalDidLoad() {
        bindSubtreeActiveState()
        lifecycleSubject.send(.didLoad)
    }

    // MARK: Private

    private let lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>()
    private var didLoadFlag = false

    private func bindSubtreeActiveState() {
        // Do not retain self here to guarantee execution. Retaining self will cause the dispose bag
        // to never be disposed, thus self is never deallocated. Also cannot just store the disposable
        // and call dispose(), since we want to keep the subscription alive until deallocation, in
        // case the router is re-attached. Using weak does require the router to be retained until its
        // interactor is deactivated.
        interactable.isActiveStream
            .sink(receiveValue: { [weak self] (isActive: Bool) in
                // When interactor becomes active, we are attached to parent, otherwise we are detached.
                self?.setSubtreeActive(isActive)
            })
            .store(in: &cancellables)

    }

    private func setSubtreeActive(_ active: Bool) {

        if active {
            iterateSubtree(self) { router in
                if !router.interactable.isActive {
                    router.interactable.activate()
                }
            }
        } else {
            iterateSubtree(self) { router in
                if router.interactable.isActive {
                    router.interactable.deactivate()
                }
            }
        }
    }

    private func iterateSubtree(_ root: Routing, closure: (_ node: Routing) -> Void) {
        closure(root)

        for child in root.children {
            iterateSubtree(child, closure: closure)
        }
    }

    private func detachAllChildren() {

        for child in children {
            detach(child: child)
        }
    }
}
