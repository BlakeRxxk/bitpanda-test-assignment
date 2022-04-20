//
//  AppDelegate.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import BitPandaCore
import UIKit

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

        let providerFactories = DependencyContainer()
        appCoordinator = AppCoordinator(in: window, with: providerFactories)
        appCoordinator?.start()

        return true
    }

    // MARK: Private

    private func setupAppearance() {
        // place for apperance
    }

}
