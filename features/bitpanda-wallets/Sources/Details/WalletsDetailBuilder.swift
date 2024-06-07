//
//  WalletsDetailBuilder.swift
//  BitPandaWallets
//

import BitPandaCore

// MARK: - Builder

protocol WalletsDetailBuildable: Buildable {
    func build(withListener listener: WalletsDetailListener, selected: SelectedWallet) -> WalletsDetailRouting
}

final class WalletsDetailBuilder: Builder<WalletsDetailDependency>, WalletsDetailBuildable {

    override init(dependency: WalletsDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: WalletsDetailListener, selected: SelectedWallet) -> WalletsDetailRouting {
        let component = WalletsDetailComponent(dependency: dependency)
        let viewController = WalletsDetailViewController()
        let interactor = WalletsDetailInteractor(
            selectedWallet: selected,
            walletsService: component.dependency.walletsService,
            presenter: viewController
        )
        interactor.listener = listener
        return WalletsDetailRouter(interactor: interactor, viewController: viewController)
    }
}
