//
//  AssetsComponent.swift
//  BitPandaAssets
//

import BitPandaCore

// MARK: - AssetsDependency

public protocol AssetsDependency: Dependency {}

// MARK: - AssetsComponent

public final class AssetsComponent: Component<AssetsDependency> {
    var assetsService: AssetsServiceProtocol {
        shared {
            AssetsService()
        }
    }
}
