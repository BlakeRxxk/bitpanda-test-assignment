//
//  PresentableInteractor.swift
//  BitPandaCore
//

import Foundation

/// Base class of an `Interactor` that actually has an associated `Presenter` and `View`.
open class PresentableInteractor<PresenterType>: Interactor {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - note: This holds a strong reference to the given `Presenter`.
    ///
    /// - parameter presenter: The presenter associated with this `Interactor`.
    public init(presenter: PresenterType) {
        self.presenter = presenter
    }

    deinit {
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    // MARK: Public

    /// The `Presenter` associated with this `Interactor`.
    public let presenter: PresenterType

}
