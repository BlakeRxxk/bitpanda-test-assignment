//
//  AssetsRouter.swift
//  BitPandaAssets
//

import BitPandaCore

// MARK: - AssetsInteractable

protocol AssetsInteractable: Interactable {
    var router: AssetsRouting? { get set }
    var listener: AssetsListener? { get set }
}

// MARK: - AssetsViewControllable

protocol AssetsViewControllable: ViewControllable { }

// MARK: - AssetsRouter

final class AssetsRouter: ViewableRouter<AssetsInteractable, AssetsViewControllable>, AssetsRouting {

    override init(interactor: AssetsInteractable, viewController: AssetsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
