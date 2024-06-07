//
//  RootBuilder.swift
//  iOSApp
//

import BitPandaCore

// MARK: - RootBuildable

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

// MARK: - RootBuilder

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    // MARK: Lifecycle

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    // MARK: Internal

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)

        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(
            assetsBuilder: component.assetsBuilder,
            walletsBuilder: component.walletsBuilder,
            interactor: interactor,
            viewController: viewController)
    }
}
