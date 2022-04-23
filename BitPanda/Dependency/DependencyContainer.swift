//
//  DependencyContainer.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import AssetsFeature
import Foundation
import WalletsFeature

// MARK: - DependencyContainer

class DependencyContainer {
//    lazy var networkManager: NetworkManager = NetworkManager()

}

// MARK: AssetsFactory

extension DependencyContainer: AssetsFactory {
    func makeAssetsCoordinator() -> AssetsCoordinator {
        AssetsCoordinator(self)
    }

    func makeAssetsViewController() -> AssetsViewController {
        let service = AssetsService()
        let viewModel = AssetsViewModel(service: service)
        return AssetsViewController(viewModel: viewModel)
    }
}

// MARK: WalletsFactory

extension DependencyContainer: WalletsFactory {
    func makeWalletsDetailView(_ passData: WalletsDetailViewDataPass) -> WalletsDetailViewController {
        let service = WalletsService()
        let viewModel = WalletsDetailViewModel(
            dataPass: passData,
            service: service)
        return WalletsDetailViewController(viewModel: viewModel)
    }

    func makeWalletsCoordinator() -> WalletsCoordinator {
        WalletsCoordinator(self)
    }

    func makeWalletsViewController() -> WalletsViewController {
        let service = WalletsService()
        let viewModel = WalletsViewModel(service: service)
        return WalletsViewController(viewModel: viewModel)
    }

}
