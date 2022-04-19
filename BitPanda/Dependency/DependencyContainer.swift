//
//  DependencyContainer.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import Foundation

// MARK: - DependencyContainer

class DependencyContainer {
//    lazy var networkManager: NetworkManager = NetworkManager()

}

// MARK: AssetsFactory

extension DependencyContainer: AssetsFactory {
    func makeAssetsCoordinator() -> AssetsCoordinator {
        AssetsCoordinator(self)
    }

    func makeAssetsViewController() -> AssetViewController {
        let viewModel = AssetsViewModel()
        return AssetViewController(viewModel: viewModel)
    }
}
