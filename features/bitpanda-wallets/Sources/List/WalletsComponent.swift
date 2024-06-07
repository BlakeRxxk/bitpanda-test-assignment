//
//  WalletsComponent.swift
//  BitPandaWallets
//

import BitPandaCore

public protocol WalletsDependency: Dependency { }

public final class WalletsComponent: Component<WalletsDependency>, WalletsDetailDependency {
    var walletsService: WalletsServiceProtocol {
        shared {
            WalletsService()
        }
    }
    
    var walletsDetail: WalletsDetailBuildable {
        WalletsDetailBuilder(dependency: self)
    }
    
    var selectedWalletPublisher: MutableSelectedWalletPublisher {
        shared {
            SelectedWalletPublisherImplementation()
        }
    }
}
