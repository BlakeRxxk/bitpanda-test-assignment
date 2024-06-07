//
//  UINavigationController+ViewControllable.swift
//  BitPandaCore
//

import Foundation
import UIKit

extension UINavigationController: ViewControllable {

    // MARK: Lifecycle

    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }

    // MARK: Public

    public var uiviewController: UIViewController { self }
}
