//
//  Navigator.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev 18.04.2022.
//

import Foundation
import UIKit

// MARK: - Navigator

public final class Navigator: NSObject, NavigatorType {

    // MARK: Lifecycle

    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        completions = [:]

        super.init()

        self.navigationController.delegate = self
    }

    // MARK: Private

    private let navigationController: UINavigationController
    private var completions: [UIViewController: () -> Void]
}

extension Navigator {

    public func popToRoot(animated: Bool) -> [UIViewController]? {
        if let poppedControllers = navigationController.popToRootViewController(animated: animated) {
            poppedControllers.forEach { runCompletion(for: $0) }
            return poppedControllers
        }
        return nil
    }

    public func popTo(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let poppedControllers = navigationController.popToViewController(viewController, animated: animated) {
            poppedControllers.forEach { runCompletion(for: $0) }
            return poppedControllers
        }
        return nil
    }

    public func pop(animated: Bool) -> UIViewController? {
        if let poppedController = navigationController.popViewController(animated: animated) {
            runCompletion(for: poppedController)
            return poppedController
        }
        return nil
    }

    public func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if let completion = completion {
            completions[viewController] = completion
        }

        navigationController.pushViewController(viewController, animated: animated)
    }

    public func setRoot(_ viewController: UIViewController, animated: Bool) {
        completions.forEach { $0.value() }
        completions = [:]
        navigationController.setViewControllers([viewController], animated: animated)
    }

}

extension Navigator {

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

}

// MARK: UINavigationControllerDelegate

extension Navigator: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow _: UIViewController,
        animated _: Bool) {
        guard
            let poppingViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppingViewController) else {
            return
        }

        runCompletion(for: poppingViewController)
    }

}
