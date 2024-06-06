//
//  DependencyContainer.swift
//  BitPanda
//

import BitPandaAssets
import BitPandaWallets
import Foundation

// MARK: - DependencyContainer

class DependencyContainer {
    lazy var assetsService: AssetsServiceProtocol = AssetsService()
    lazy var walletsService: WalletsServiceProtocol = WalletsService()
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
