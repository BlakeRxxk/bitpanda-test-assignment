//
//  AssetsCoordinator.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import UIKit
import BitPandaCore

final class AssetsCoordinator: NavigatableCoordinator {
    
    var identifier: String = UUID().uuidString
    var childCoordinators: [String: Coordinator] = [:]
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let assetsViewController: AssetViewController
    
    
    init() {
        let assetsViewController = AssetViewController()
        self.assetsViewController = assetsViewController
        
        let navigationController = UINavigationController(rootViewController: assetsViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        //
    }
    
}
