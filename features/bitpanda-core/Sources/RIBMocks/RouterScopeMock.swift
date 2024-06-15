//
//  RouterScopeMock.swift
//  BitPandaCore
//

import Combine
import Foundation

public class RouterScopeMock: RouterScope {

    // MARK: Lifecycle

    public init() { }

    // MARK: Public

    public private(set) var lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>()

    public var lifecycle: AnyPublisher<RouterLifecycle, Never> { lifecycleSubject.eraseToAnyPublisher() }
}
