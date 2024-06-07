//
//  WalletsDetailRouter.swift
//  BitPandaWallets
//

import BitPandaCore

protocol WalletsDetailInteractable: Interactable {
    var router: WalletsDetailRouting? { get set }
    var listener: WalletsDetailListener? { get set }
}

protocol WalletsDetailViewControllable: ViewControllable {
}

final class WalletsDetailRouter: ViewableRouter<WalletsDetailInteractable, WalletsDetailViewControllable>, WalletsDetailRouting {

    override init(interactor: WalletsDetailInteractable, viewController: WalletsDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
