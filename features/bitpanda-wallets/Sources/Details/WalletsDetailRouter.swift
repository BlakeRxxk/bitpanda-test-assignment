//
//  WalletsDetailRouter.swift
//  BitPandaWallets
//

import BitPandaCore

// MARK: - WalletsDetailInteractable

protocol WalletsDetailInteractable: Interactable {
    var router: WalletsDetailRouting? { get set }
    var listener: WalletsDetailListener? { get set }
}

// MARK: - WalletsDetailViewControllable

protocol WalletsDetailViewControllable: ViewControllable {
}

// MARK: - WalletsDetailRouter

final class WalletsDetailRouter: ViewableRouter<WalletsDetailInteractable, WalletsDetailViewControllable>, WalletsDetailRouting {

    override init(interactor: WalletsDetailInteractable, viewController: WalletsDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
