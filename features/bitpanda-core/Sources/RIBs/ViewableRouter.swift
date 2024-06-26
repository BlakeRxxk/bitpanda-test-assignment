//
//  ViewableRouter.swift
//  BitPandaCore
//

// MARK: - ViewableRouting

/// The base protocol for all routers that own their own view controllers.
public protocol ViewableRouting: Routing {

    // The following methods must be declared in the base protocol, since `Router` internally invokes these methods.
    // In order to unit test router with a mock child router, the mocked child router first needs to conform to the
    // custom subclass routing protocol, and also this base protocol to allow the `Router` implementation to execute
    // base class logic without error.

    /// The base view controllable associated with this `Router`.
    var viewControllable: ViewControllable { get }
}

// MARK: - ViewableRouter

/// The base class of all routers that owns view controllers, representing application states.
///
/// A `Router` acts on inputs from its corresponding interactor, to manipulate application state and view state,
/// forming a tree of routers that drives the tree of view controllers. Router drives the lifecycle of its owned
/// interactor. `Router`s should always use helper builders to instantiate children `Router`s.
open class ViewableRouter<InteractorType, ViewControllerType>: Router<InteractorType>, ViewableRouting {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter interactor: The corresponding `Interactor` of this `Router`.
    /// - parameter viewController: The corresponding `ViewController` of this `Router`.
    public init(interactor: InteractorType, viewController: ViewControllerType) {
        self.viewController = viewController
        guard let viewControllable = viewController as? ViewControllable else {
            fatalError("\(viewController) should conform to \(ViewControllable.self)")
        }
        self.viewControllable = viewControllable

        super.init(interactor: interactor)
    }

    // MARK: Public

    /// The corresponding `ViewController` owned by this `Router`.
    public let viewController: ViewControllerType

    /// The base `ViewControllable` associated with this `Router`.
    public let viewControllable: ViewControllable

    // MARK: Internal

    override func internalDidLoad() {
        setupViewControllerLeakDetection()

        super.internalDidLoad()
    }

    // MARK: Private

    private var viewControllerDisappearExpectation: LeakDetectionHandle?

    private func setupViewControllerLeakDetection() {
        // Do not retain self here to guarantee execution. Retaining self will cause the dispose bag to never be
        // disposed, thus self is never deallocated. Also cannot just store the disposable and call dispose(),
        // since we want to keep the subscription alive until deallocation, in case the router is re-attached.
        // Using weak does require the router to be retained until its interactor is deactivated.
        interactable.isActiveStream
            .sink(receiveValue: { [weak self] (isActive: Bool) in
                guard let self else { return }
                self.viewControllerDisappearExpectation?.cancel()
                self.viewControllerDisappearExpectation = nil

                if !isActive {
                    let viewController = self.viewControllable.uiviewController
                    self.viewControllerDisappearExpectation = LeakDetector.instance
                        .expectViewControllerDisappear(viewController: viewController)
                }
            })
            .store(in: &cancellables)
    }
}
