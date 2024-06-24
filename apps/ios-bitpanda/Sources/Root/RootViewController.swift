//
//  RootViewController.swift
//  iOSApp
//

import BitPandaCore
import UIKit

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject { }

// MARK: - RootViewController

final class RootViewController: UITabBarController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?

    func attach(_ viewControllers: [any ViewControllable], animated _: Bool) {
        setViewControllers(
            viewControllers.map { $0.uiviewController },
            animated: false)
    }
}
