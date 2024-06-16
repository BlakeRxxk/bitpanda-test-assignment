//
//  RootRouter.swift
//  iOSApp
//

import BitPandaAssets
import BitPandaCore
import BitPandaWallets
import UIKit

// MARK: - RootInteractable

/// @mockable
protocol RootInteractable: Interactable, AssetsListener, WalletsListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

// MARK: - RootViewControllable

/// @mockable
protocol RootViewControllable: ViewControllable {
    func attach(_ viewControllers: [ViewControllable], animated: Bool)
}

// MARK: - RootRouter

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // MARK: Lifecycle

    init(
        assetsBuilder: AssetsBuildable,
        walletsBuilder: WalletsBuildable,
        interactor: RootInteractable,
        viewController: RootViewControllable) {
        self.assetsBuilder = assetsBuilder
        self.walletsBuilder = walletsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // MARK: Private

    private let assetsBuilder: AssetsBuildable
    private var assetsRouting: AssetsRouting?

    private let walletsBuilder: WalletsBuildable
    private var walletsRouting: WalletsRouting?
}

extension RootRouter {

    // MARK: Internal

    func attachTabs() {
        let tabs: [ViewControllable] = [
            UINavigationController(root: attachAssets()),
            UINavigationController(root: attachWallets()),
        ]

        viewController.attach(tabs, animated: false)
    }

    // MARK: Private

    private func attachAssets() -> ViewControllable {
        let router = assetsBuilder.build(withListener: interactor)
        assetsRouting = router
        attach(child: router)
        router.viewControllable.uiviewController.tabBarItem = UITabBarItem(
            title: Localized.assets,
            image: UIImage.assets,
            tag: 1)
        return router.viewControllable
    }

    private func attachWallets() -> ViewControllable {
        let router = walletsBuilder.build(withListener: interactor)
        walletsRouting = router
        attach(child: router)
        router.viewControllable.uiviewController.tabBarItem = UITabBarItem(
            title: Localized.wallets,
            image: UIImage.wallet,
            tag: 0)
        return router.viewControllable
    }
}

extension RootRouter {
    fileprivate enum Localized {
        static let assets = "assets".localize()
        static let wallets = "wallets".localize()
    }
}
