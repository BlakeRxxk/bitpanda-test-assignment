//
//  AppCoordinator.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 13.04.2022.
//

import BitPandaCore
import UIKit

final class AppCoordinator: PresentationCoordinator {

    // MARK: Lifecycle

    init(in window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    // MARK: Internal

    var identifier: String = UUID().uuidString

    var childCoordinators: [String: Coordinator] = [:]
    var rootViewController = UITabBarController()


    func start() {
        let assetsCoordinator = AssetsCoordinator()
        let walletsCoordinator = WalletsCoordinator()

        walletsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "assets", image: nil, tag: 0)
        assetsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "wallets", image: nil, tag: 1)

        rootViewController.setViewControllers([
            walletsCoordinator.rootViewController,
            assetsCoordinator.rootViewController,
        ], animated: false)
    }

}
