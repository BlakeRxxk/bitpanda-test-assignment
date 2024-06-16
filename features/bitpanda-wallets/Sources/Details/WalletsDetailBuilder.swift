//
//  WalletsDetailBuilder.swift
//  BitPandaWallets
//

import BitPandaCore

// MARK: - WalletsDetailBuildable

/// @mockable
public protocol WalletsDetailBuildable: Buildable {
    func build(withListener listener: WalletsDetailListener, selected: SelectedWallet) -> WalletsDetailRouting
}

// MARK: - WalletsDetailBuilder

final class WalletsDetailBuilder: Builder<WalletsDetailDependency>, WalletsDetailBuildable {

    // MARK: Lifecycle

    override init(dependency: WalletsDetailDependency) {
        super.init(dependency: dependency)
    }

    // MARK: Internal

    func build(withListener listener: WalletsDetailListener, selected: SelectedWallet) -> WalletsDetailRouting {
        let component = WalletsDetailComponent(dependency: dependency)
        let viewController = WalletsDetailViewController()
        let interactor = WalletsDetailInteractor(
            selectedWallet: selected,
            walletsService: component.dependency.walletsService,
            presenter: viewController)
        interactor.listener = listener
        return WalletsDetailRouter(interactor: interactor, viewController: viewController)
    }
}
