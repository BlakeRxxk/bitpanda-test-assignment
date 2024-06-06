//
//  RootViewController.swift
//  iOSApp
//

import BitPandaCore
import UIKit

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

// MARK: - RootViewController

final class RootViewController: UITabBarController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?

    func attach(_ viewControllers: [any ViewControllable], animated _: Bool) {
        setViewControllers(
            viewControllers.map { $0.uiviewController },
            animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}
