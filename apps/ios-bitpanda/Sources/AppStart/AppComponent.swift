//
//  AppComponent.swift
//  iOSApp
//

import BitPandaCore

// MARK: - AppComponent

class AppComponent: Component<EmptyDependency>, RootDependency {
    // MARK: Lifecycle

    init() {
        super.init(dependency: EmptyComponent())
    }

    // MARK: Internal

    var rootBuilder: RootBuildable {
        RootBuilder(dependency: self)
    }
}
