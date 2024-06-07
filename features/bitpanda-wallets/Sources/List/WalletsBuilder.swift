//
//  WalletsBuilder.swift
//  BitPandaWallets
//

import BitPandaCore

// MARK: - Builder

public protocol WalletsBuildable: Buildable {
    func build(withListener listener: WalletsListener) -> WalletsRouting
}

public final class WalletsBuilder: Builder<WalletsDependency>, WalletsBuildable {

    public override init(dependency: WalletsDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: WalletsListener) -> WalletsRouting {
        let component = WalletsComponent(dependency: dependency)
        let viewController = WalletsViewController()
        let interactor = WalletsInteractor(walletsService: component.walletsService, presenter: viewController)
        interactor.listener = listener

        return WalletsRouter(
            walletDetailBuilder: component.walletsDetail,
            interactor: interactor,
            viewController: viewController)
    }
}
