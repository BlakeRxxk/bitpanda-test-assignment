//
//  WalletsRouter.swift
//  BitPandaWallets
//

import BitPandaCore
import UIKit

// MARK: - WalletsInteractable

protocol WalletsInteractable: Interactable, WalletsDetailListener {
    var router: WalletsRouting? { get set }
    var listener: WalletsListener? { get set }
}

// MARK: - WalletsViewControllable

protocol WalletsViewControllable: ViewControllable { }

// MARK: - WalletsRouter

final class WalletsRouter: ViewableRouter<WalletsInteractable, WalletsViewControllable>, WalletsRouting {

    // MARK: Lifecycle

    init(
        walletDetailBuilder: WalletsDetailBuildable,
        interactor: WalletsInteractable,
        viewController: WalletsViewControllable) {
        self.walletDetailBuilder = walletDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // MARK: Private

    private let walletDetailBuilder: WalletsDetailBuildable
    private var walletDetailRouter: WalletsDetailRouting?
}

extension WalletsRouter {
    func attachDetailView(with model: SelectedWallet) {
        guard walletDetailRouter == nil else { return }

        let router = walletDetailBuilder.build(
            withListener: interactor,
            selected: model)
        walletDetailRouter = router
        attach(child: router)
        let root = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        viewController.uiviewController.present(root, animated: true)
    }

    func detachWalletDetail() {
        guard let router = walletDetailRouter else { return }
        walletDetailRouter = nil
        detach(child: router)
        viewController.uiviewController.dismiss(animated: true)
    }
}
