//
//  RootComponent.swift
//  iOSApp
//

import BitPandaAssets
import BitPandaCore

// MARK: - RootDependency

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

// MARK: - RootComponent

final class RootComponent: Component<RootDependency>, AssetsDependency {
    var assetsBuilder: AssetsBuildable {
        AssetsBuilder(dependency: self)
    }
}
