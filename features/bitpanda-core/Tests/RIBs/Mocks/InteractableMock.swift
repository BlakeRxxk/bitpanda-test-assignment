//
//  InteractableMock.swift
//  BitPandaCoreTests
//

import BitPandaCore
import Combine
import Foundation

class InteractableMock: Interactable {

    // MARK: Lifecycle

    init() {}

    // MARK: Internal

    var isActiveSetCallCount = 0
    var isActiveStreamSubjectSetCallCount = 0
    // Function Handlers
    var activateHandler: (() -> Void)?
    var activateCallCount = 0
    var deactivateHandler: (() -> Void)?
    var deactivateCallCount = 0

    // Variables
    var isActive = false { didSet { isActiveSetCallCount += 1 } }
    var isActiveStreamSubject: PassthroughSubject<Bool, Never> = .init() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
    var isActiveStream: AnyPublisher<Bool, Never> { isActiveStreamSubject.eraseToAnyPublisher() }

    func activate() {
        activateCallCount += 1
        if let activateHandler = activateHandler {
            return activateHandler()
        }
    }

    func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler = deactivateHandler {
            return deactivateHandler()
        }
    }
}
