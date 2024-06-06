//
//  AssetsBuilder.swift
//  BitPandaAssets
//

import BitPandaCore

// MARK: - AssetsBuildable

public protocol AssetsBuildable: Buildable {
    func build(withListener listener: AssetsListener) -> AssetsRouting
}

// MARK: - AssetsBuilder

public final class AssetsBuilder: Builder<AssetsDependency>, AssetsBuildable {
    public func build(withListener listener: AssetsListener) -> AssetsRouting {
        let component = AssetsComponent(dependency: dependency)
        let viewController = AssetsViewController()
        let interactor = AssetsInteractor(assetsService: component.assetsService, presenter: viewController)
        interactor.listener = listener
        return AssetsRouter(interactor: interactor, viewController: viewController)
    }
}
