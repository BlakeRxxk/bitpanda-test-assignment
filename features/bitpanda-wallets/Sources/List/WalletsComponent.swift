//
//  WalletsComponent.swift
//  BitPandaWallets
//

import BitPandaCore

// MARK: - WalletsDependency

public protocol WalletsDependency: Dependency { }

// MARK: - WalletsComponent

public final class WalletsComponent: Component<WalletsDependency>, WalletsDetailDependency {
    var walletsService: WalletsServiceProtocol {
        shared {
            WalletsService()
        }
    }

    var walletsDetail: WalletsDetailBuildable {
        WalletsDetailBuilder(dependency: self)
    }
}
