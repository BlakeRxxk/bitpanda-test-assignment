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
    lazy var assetsService: AssetsServiceProtocol = AssetsService()
    lazy var walletsService: WalletsServiceProtocol = WalletsService()
}

// MARK: AssetsFactory

extension DependencyContainer: AssetsFactory {
    func makeAssetsCoordinator() -> AssetsCoordinator {
        AssetsCoordinator(self)
    }

    func makeAssetsViewController() -> AssetsViewController {
        let viewModel = AssetsViewModel(service: assetsService)
        return AssetsViewController(viewModel: viewModel)
    }
}

// MARK: WalletsFactory

extension DependencyContainer: WalletsFactory {
    func makeWalletsDetailView(_ passData: WalletsDetailViewDataPass) -> WalletsDetailViewController {
        let viewModel = WalletsDetailViewModel(
            dataPass: passData,
            service: walletsService)
        return WalletsDetailViewController(viewModel: viewModel)
    }

    func makeWalletsCoordinator() -> WalletsCoordinator {
        WalletsCoordinator(self)
    }

    func makeWalletsViewController() -> WalletsViewController {
        let viewModel = WalletsViewModel(service: walletsService)
        return WalletsViewController(viewModel: viewModel)
    }

}
