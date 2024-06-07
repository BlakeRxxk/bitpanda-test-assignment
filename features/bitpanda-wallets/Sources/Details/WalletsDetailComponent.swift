//
//  WalletsDetailComponent.swift
//  BitPandaWallets
//

import Foundation

import BitPandaCore

// MARK: - WalletsDetailDependency

protocol WalletsDetailDependency: Dependency {
    var walletsService: WalletsServiceProtocol { get }
}

// MARK: - WalletsDetailComponent

final class WalletsDetailComponent: Component<WalletsDetailDependency> {

}
