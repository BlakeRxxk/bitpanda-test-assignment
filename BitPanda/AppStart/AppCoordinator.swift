//
//  AppCoordinator.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 13.04.2022.
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
        let assetsCoordinator = container.makeAssetsCoordinator()
        let walletsCoordinator = container.makeWalletsCoordinator()

        walletsCoordinator
            .rootViewController
            .tabBarItem = UITabBarItem(
                title: Localized.assets,
                image: UIImage.wallet,
                tag: 0)

        assetsCoordinator
            .rootViewController
            .tabBarItem = UITabBarItem(
                title: Localized.wallets,
                image: UIImage.assets,
                tag: 1)
        attachChild(assetsCoordinator)
        attachChild(walletsCoordinator)

        assetsCoordinator.start()
        walletsCoordinator.start()

        rootViewController.setViewControllers([
            walletsCoordinator.rootViewController,
            assetsCoordinator.rootViewController,
        ], animated: false)
    }

}

extension AppCoordinator {
    fileprivate enum Localized {
        static let assets = "Assets"
        static let wallets = "Wallets"
    }
}
