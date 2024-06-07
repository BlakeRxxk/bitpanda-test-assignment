//
//  WalletsRouter.swift
//  BitPandaWallets
//

import BitPandaCore
import UIKit

protocol WalletsInteractable: Interactable, WalletsDetailListener {
    var router: WalletsRouting? { get set }
    var listener: WalletsListener? { get set }
}

protocol WalletsViewControllable: ViewControllable { }

final class WalletsRouter: ViewableRouter<WalletsInteractable, WalletsViewControllable>, WalletsRouting {
    private let walletDetailBuilder: WalletsDetailBuildable
    private var walletDetailRouter: WalletsDetailRouting?
    
    init(walletDetailBuilder: WalletsDetailBuildable,
         interactor: WalletsInteractable,
         viewController: WalletsViewControllable) {
        self.walletDetailBuilder = walletDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension WalletsRouter {
    func attachDetailView(with model: SelectedWallet) {
        guard walletDetailRouter == nil else { return }
        
        let router = walletDetailBuilder.build(withListener: interactor,
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
