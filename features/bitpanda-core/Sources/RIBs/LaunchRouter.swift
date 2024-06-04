//
//  LaunchRouter.swift
//  BitPandaCore
//

import UIKit

// MARK: - LaunchRouting

/// The root `Router` of an application.
public protocol LaunchRouting: ViewableRouting {

    /// Launches the router tree.
    ///
    /// - parameter window: The application window to launch from.
    func launch(from window: UIWindow)
}

// MARK: - LaunchRouter

/// The application root router base class, that acts as the root of the router tree.
open class LaunchRouter<InteractorType, ViewControllerType>: ViewableRouter<InteractorType, ViewControllerType>, LaunchRouting {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter interactor: The corresponding `Interactor` of this `Router`.
    /// - parameter viewController: The corresponding `ViewController` of this `Router`.
    public override init(interactor: InteractorType, viewController: ViewControllerType) {
        super.init(interactor: interactor, viewController: viewController)
    }

    // MARK: Public

    /// Launches the router tree.
    ///
    /// - parameter window: The window to launch the router tree in.
    public final func launch(from window: UIWindow) {
        window.rootViewController = viewControllable.uiviewController
        window.makeKeyAndVisible()

        interactable.activate()
        load()
    }
}
