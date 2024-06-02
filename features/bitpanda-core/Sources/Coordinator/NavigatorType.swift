//
//  NavigatorType.swift
//  BitPandaCore
//

import Foundation
import UIKit

// MARK: - NavigatorType

public protocol NavigatorType {

    @discardableResult
    func popToRoot(animated: Bool) -> [UIViewController]?

    @discardableResult
    func popTo(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?

    @discardableResult
    func pop(animated: Bool) -> UIViewController?

    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    func setRoot(_ viewController: UIViewController, animated: Bool)
}

extension NavigatorType {
    public func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, completion: nil)
    }

}
