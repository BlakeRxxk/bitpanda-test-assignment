//
//  AssetsCoordinator.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import BitPandaCore
import UIKit

final class AssetsCoordinator: NavigatableCoordinator {

    // MARK: Lifecycle

    init(_ container: DependencyContainer) {

        assetsViewController = container.makeAssetsViewController()

        let navigationController = UINavigationController(rootViewController: assetsViewController)
        navigator = Navigator(navigationController: navigationController)
        rootViewController = navigationController
    }

    // MARK: Internal

    var identifier: String = UUID().uuidString
    var childCoordinators: [String: Coordinator] = [:]
    var navigator: NavigatorType
    var rootViewController: UINavigationController

    func start() {
        //
    }

    // MARK: Private

    private let assetsViewController: AssetViewController

}
