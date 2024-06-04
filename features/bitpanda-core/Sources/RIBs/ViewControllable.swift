//
//  ViewControllable.swift
//  BitPandaCore
//

import UIKit

// MARK: - ViewControllable

/// Basic interface between a `Router` and the UIKit `UIViewController`.
public protocol ViewControllable: AnyObject {
    var uiviewController: UIViewController { get }
}

/// Default implementation on `UIViewController` to conform to `ViewControllable` protocol
extension ViewControllable where Self: UIViewController {
    public var uiviewController: UIViewController { self }
}
