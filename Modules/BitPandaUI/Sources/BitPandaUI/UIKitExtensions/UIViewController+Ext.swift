//
//  UIViewController+Ext.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import Foundation
import UIKit

extension UIViewController {

    public func addCloseButtonIfNeeded(target: AnyObject = UIViewController.self as AnyObject, action: Selector) {
        guard navigationController?.viewControllers.last === self else { return }

        let item = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.stop,
            target: target,
            action: action)
        navigationItem.leftBarButtonItem = item
    }
}
