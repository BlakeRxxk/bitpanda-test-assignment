//
//  PresentableCoordinator.swift
//  BitPandaCore
//

import Foundation
import UIKit

// MARK: - PresentableCoordinator

public protocol PresentableCoordinator: Coordinator {
    var root: UIViewController { get }
}

// MARK: - PresentationCoordinator

public protocol PresentationCoordinator: PresentableCoordinator {
    associatedtype ViewController: UIViewController
    var rootViewController: ViewController { get }
}

extension PresentationCoordinator {
    public var root: UIViewController { rootViewController }
}

extension PresentationCoordinator {

    public func present(_ coordinator: PresentableCoordinator, animated: Bool) {
        attachChild(coordinator)
        coordinator.start()
        rootViewController.present(coordinator.root, animated: animated)
    }

    public func dismiss(
        _ coordinator: PresentableCoordinator,
        animated: Bool,
        completion: (() -> Void)? = nil) {
        coordinator.root.dismiss(
            animated: animated,
            completion: completion)

        detachChild(coordinator)
    }
}
