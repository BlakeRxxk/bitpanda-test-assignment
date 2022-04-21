//
//  DependencyContainer.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import AssetsFeature
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

    func makeAssetsViewController() -> AssetsViewController {
        let service = AssetsService()
        let viewModel = AssetsViewModel(service: service)
        return AssetsViewController(viewModel: viewModel)
    }
}
