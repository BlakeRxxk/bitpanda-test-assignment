//
//  WalletsCoordinator.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import UIKit
import BitPandaCore

final class WalletsCoordinator: NavigatableCoordinator {
    
    var identifier: String = UUID().uuidString
    var childCoordinators: [String: Coordinator] = [:]
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let walletsViewController: WalletsViewController
    
    
    init() {
        let walletsViewController = WalletsViewController()
        self.walletsViewController = walletsViewController
        
        let navigationController = UINavigationController(rootViewController: walletsViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        //
    }
    
}
