//
//  AppDelegate.swift
//  BitPanda
//

import BitPandaCore
import BitPandaUI
import UIKit

// MARK: - AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Internal

    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {

        window = UIWindow()
        guard let window = window else { return false }
        setupAppearance()
        let appComponent = AppComponent()
        launchRouter = appComponent.rootBuilder.build()
        launchRouter?.launch(from: window)
        return true
    }

    // MARK: Private

    private var launchRouter: LaunchRouting?

    private func setupAppearance() {
        UITabBar.appearance().barTintColor = Theme.Background.tabBar
        UITabBar.appearance().tintColor = Theme.Text.primary
        UITabBar.appearance().unselectedItemTintColor = Theme.Background.iconInactive

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = Theme.Background.tabBar
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: Theme.Text.primary,
            .font: UIFont.Display.small,
        ]
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: Theme.Text.primary,
            .font: UIFont.Heading.header2,
        ]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}

extension AppDelegate {
    fileprivate enum Constants {
        static let diskLimit: UInt = 50 * 1024 * 1024 // limit cache with 50MB
        static let ageLimit: TimeInterval = 60 * 60 * 24 * 10 // limit cache age with 10 days
    }
}
