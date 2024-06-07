//
//  RootComponent.swift
//  iOSApp
//

import BitPandaAssets
import BitPandaCore
import BitPandaWallets

// MARK: - RootDependency

protocol RootDependency: Dependency { }

// MARK: - RootComponent

final class RootComponent: Component<RootDependency>, AssetsDependency, WalletsDependency {
    var assetsBuilder: AssetsBuildable {
        AssetsBuilder(dependency: self)
    }

    var walletsBuilder: WalletsBuildable {
        WalletsBuilder(dependency: self)
    }
}
