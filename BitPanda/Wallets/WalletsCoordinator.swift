//
//  WalletsCoordinator.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import BitPandaCore
import UIKit

final class WalletsCoordinator: NavigatableCoordinator {

    // MARK: Lifecycle

    init() {
        let walletsViewController = WalletsViewController()
        self.walletsViewController = walletsViewController

        let navigationController = UINavigationController(rootViewController: walletsViewController)
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

    private let walletsViewController: WalletsViewController

}
