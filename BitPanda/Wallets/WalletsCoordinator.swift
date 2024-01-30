//
//  WalletsCoordinator.swift
//  BitPanda
//

import BitPandaCore
import UIKit
import WalletsFeature

// MARK: - WalletsCoordinator

final class WalletsCoordinator: NavigatableCoordinator {

    // MARK: Lifecycle

    init(_ container: DependencyContainer) {
        walletsViewController = container.makeWalletsViewController()

        let navigationController = UINavigationController(rootViewController: walletsViewController)
        navigator = Navigator(navigationController: navigationController)
        rootViewController = navigationController
        self.container = container
    }

    // MARK: Internal

    var identifier: String = UUID().uuidString
    var childCoordinators: [String: Coordinator] = [:]
    var navigator: NavigatorType
    var rootViewController: UINavigationController

    func start() {
        walletsViewController.output = self
    }

    // MARK: Private

    private let walletsViewController: WalletsViewController
    private var container: DependencyContainer

}

// MARK: WalletsViewControllerOutput

extension WalletsCoordinator: WalletsViewControllerOutput {
    func presentDetailView(_ passData: WalletsDetailViewDataPass) {
        let viewController = container.makeWalletsDetailView(passData)
        let root = UINavigationController(rootViewController: viewController)
        rootViewController.present(root, animated: true)
    }

}
