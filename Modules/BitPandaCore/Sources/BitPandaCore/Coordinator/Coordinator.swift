//
//  Coordinator.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import Foundation
import UIKit

// MARK: - Coordinator

public protocol Coordinator: AnyObject {
    var identifier: String { get }
    var childCoordinators: [String: Coordinator] { get set }

    func start()
}

extension Coordinator {
    public func attachChild(_ coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    public func detachChild(_ coordinator: Coordinator) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
}
