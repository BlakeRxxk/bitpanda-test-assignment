//
//  InteractorScopeMock.swift
//  BitPandaCore
//

import Combine
import Foundation

public class InteractorScopeMock: InteractorScope {

    // MARK: Lifecycle

    public init() { }
    public init(isActive: Bool = false) {
        self.isActive = isActive
    }

    // MARK: Public

    public private(set) var isActiveSetCallCount = 0
    public private(set) var isActiveStreamSubject = PassthroughSubject<Bool, Never>()

    public var isActive = false { didSet { isActiveSetCallCount += 1 } }

    public var isActiveStream: AnyPublisher<Bool, Never> { isActiveStreamSubject.eraseToAnyPublisher() }
}
