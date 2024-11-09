//
//  InteractableMock.swift
//  BitPandaCore
//

import Combine
import Foundation

public class InteractableMock: Interactable {

    // MARK: Lifecycle

    public init() { }
    public init(isActive: Bool = false) {
        self.isActive = isActive
    }

    // MARK: Public

    public private(set) var isActiveSetCallCount = 0
    public private(set) var isActiveStreamSubject = PassthroughSubject<Bool, Never>()

    public private(set) var activateCallCount = 0
    public var activateHandler: (() -> Void)?
    public private(set) var deactivateCallCount = 0
    public var deactivateHandler: (() -> Void)?

    public var isActive = false { didSet { isActiveSetCallCount += 1 } }

    public var isActiveStream: AnyPublisher<Bool, Never> { isActiveStreamSubject.eraseToAnyPublisher() }

    public func activate() {
        activateCallCount += 1
        if let activateHandler {
            activateHandler()
        }
    }

    public func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler {
            deactivateHandler()
        }
    }
}
