//
//  NavigatableCoordinator.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import Foundation
import UIKit

// MARK: - NavigatableCoordinator

public protocol NavigatableCoordinator: PresentationCoordinator {
    var navigator: NavigatorType { get }
}

extension NavigatableCoordinator {

    public func push(_ coordinator: PresentableCoordinator, animated: Bool) {
        attachChild(coordinator)
        coordinator.start()
        navigator.push(
            coordinator.root,
            animated: animated,
            completion: { [weak self] in
                self?.detachChild(coordinator)
            })
    }

}
