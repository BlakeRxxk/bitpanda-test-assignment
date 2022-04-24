//
//  AppDelegate.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import BitPandaCore
import BitPandaUI
import PINCache
import UIKit

// MARK: - AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Internal

    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {

        window = UIWindow()
        guard let window = window else { return false }
        setupCache()
        setupAppearance()

        let providerFactories = DependencyContainer()
        appCoordinator = AppCoordinator(in: window, with: providerFactories)
        appCoordinator?.start()

        return true
    }

    // MARK: Private

    private func setupAppearance() {
        UITabBar.appearance().barTintColor = Theme.Background.tabBar
        UITabBar.appearance().tintColor = Theme.Text.primary
        UITabBar.appearance().unselectedItemTintColor = Theme.Background.iconInactive
    }

    private func setupCache() {
        PINCache.shared.diskCache.byteLimit = Constants.diskLimit
        PINCache.shared.diskCache.ageLimit = Constants.ageLimit
        PINCache.shared.memoryCache.ageLimit = Constants.ageLimit
    }

}

extension AppDelegate {
    fileprivate enum Constants {
        static let diskLimit: UInt = 50 * 1024 * 1024 // limit cache with 50MB
        static let ageLimit: TimeInterval = 60 * 60 * 24 * 10 // limit cache age with 10 days
    }
}
