//
//  WalletsDetailComponent.swift
//  BitPandaWallets
//

import Foundation

import BitPandaCore

protocol WalletsDetailDependency: Dependency {
    var walletsService: WalletsServiceProtocol { get }
    var selectedWalletPublisher: MutableSelectedWalletPublisher { get }
}

final class WalletsDetailComponent: Component<WalletsDetailDependency> {
    
}
