//
//  RootInteractor.swift
//  iOSApp
//

import BitPandaCore

// MARK: - RootRouting

/// @mockable
protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachTabs()
}

// MARK: - RootPresentable

/// @mockable
protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

// MARK: - RootListener

/// @mockable
protocol RootListener: AnyObject { }

// MARK: - RootInteractor

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    // MARK: Lifecycle

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: RootRouting?
    weak var listener: RootListener?

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachTabs()
    }
}
