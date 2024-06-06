//
//  AppCoordinator.swift
//  BitPanda
//

import BitPandaCore
import BitPandaUI
import UIKit

// MARK: - AppCoordinator

final class AppCoordinator: PresentationCoordinator {

    // MARK: Lifecycle

    init(in window: UIWindow, with container: DependencyContainer) {
        self.container = container
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    // MARK: Internal

    var identifier: String = UUID().uuidString
    var container: DependencyContainer
    var childCoordinators: [String: Coordinator] = [:]
    var rootViewController = UITabBarController()

    func start() {
        let walletsCoordinator = container.makeWalletsCoordinator()

        walletsCoordinator
            .rootViewController
            .tabBarItem = UITabBarItem(
                title: Localized.wallets,
                image: UIImage.wallet,
                tag: 0)

        attachChild(walletsCoordinator)

        walletsCoordinator.start()

        rootViewController.setViewControllers([
            walletsCoordinator.rootViewController,
        ], animated: false)
    }

}

extension AppCoordinator {
    fileprivate enum Localized {
        static let assets = "assets".localize()
        static let wallets = "wallets".localize()
    }
}
