//
//  InteractorMock.swift
//  BitPandaCoreTests
//

import BitPandaCore
import Combine
import Foundation

class InteractorMock: Interactable {

    // MARK: Lifecycle

    init() {}

    // MARK: Internal

    var isActive: Bool { active.value }

    var isActiveStream: AnyPublisher<Bool, Never> { active.eraseToAnyPublisher() }

    func activate() {
        active.send(true)
    }

    func deactivate() {
        active.send(false)
    }

    // MARK: Private

    private let active = CurrentValueSubject<Bool, Never>(false)

}
