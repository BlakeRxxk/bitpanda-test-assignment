//
//  WalletsBuilder.swift
//  BitPandaWallets
//

import BitPandaCore

// MARK: - WalletsBuildable

public protocol WalletsBuildable: Buildable {
    func build(withListener listener: WalletsListener) -> WalletsRouting
}

// MARK: - WalletsBuilder

public final class WalletsBuilder: Builder<WalletsDependency>, WalletsBuildable {

    // MARK: Lifecycle

    public override init(dependency: WalletsDependency) {
        super.init(dependency: dependency)
    }

    // MARK: Public

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
