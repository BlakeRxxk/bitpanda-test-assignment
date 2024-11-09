//
//  WorkingMock.swift
//  BitPandaCore
//

import Combine
import Foundation

public class WorkingMock: Working {

    // MARK: Lifecycle

    public init() { }
    public init(isStarted: Bool = false) {
        self.isStarted = isStarted
    }

    // MARK: Public

    public private(set) var startCallCount = 0
    public var startHandler: ((InteractorScope) -> Void)?
    public private(set) var stopCallCount = 0
    public var stopHandler: (() -> Void)?
    public private(set) var isStartedSetCallCount = 0
    public private(set) var isStartedPublisherSubject = PassthroughSubject<Bool, Never>()

    public var isStarted = false { didSet { isStartedSetCallCount += 1 } }

    public var isStartedPublisher: AnyPublisher<Bool, Never> { isStartedPublisherSubject.eraseToAnyPublisher() }

    public func start(_ scope: InteractorScope) {
        startCallCount += 1
        if let startHandler {
            startHandler(scope)
        }
    }

    public func stop() {
        stopCallCount += 1
        if let stopHandler {
            stopHandler()
        }
    }

}
