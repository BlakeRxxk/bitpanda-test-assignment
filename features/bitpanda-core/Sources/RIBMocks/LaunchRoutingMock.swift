//
//  LaunchRoutingMock.swift
//  BitPandaCore
//

import Combine
import Foundation
import UIKit

public class LaunchRoutingMock: LaunchRouting {

    // MARK: Lifecycle

    public init() { }
    public init(
        viewControllable: ViewControllable = ViewControllableMock(),
        interactable: Interactable = InteractableMock(),
        children: [Routing] = [Routing]()) {
        self.viewControllable = viewControllable
        self.interactable = interactable
        self.children = children
    }

    // MARK: Public

    public private(set) var launchCallCount = 0
    public var launchHandler: ((UIWindow) -> Void)?
    public private(set) var lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>()

    public private(set) var viewControllableSetCallCount = 0
    public private(set) var interactableSetCallCount = 0
    public private(set) var childrenSetCallCount = 0
    public private(set) var loadCallCount = 0
    public var loadHandler: (() -> Void)?
    public private(set) var attachCallCount = 0
    public var attachHandler: ((Routing) -> Void)?
    public private(set) var detachCallCount = 0
    public var detachHandler: ((Routing) -> Void)?

    public var lifecycle: AnyPublisher<RouterLifecycle, Never> { lifecycleSubject.eraseToAnyPublisher() }
    public var viewControllable: ViewControllable = ViewControllableMock() { didSet { viewControllableSetCallCount += 1 } }

    public var interactable: Interactable = InteractableMock() { didSet { interactableSetCallCount += 1 } }

    public var children = [Routing]() { didSet { childrenSetCallCount += 1 } }

    public func launch(from window: UIWindow) {
        launchCallCount += 1
        if let launchHandler {
            launchHandler(window)
        }
    }

    public func load() {
        loadCallCount += 1
        if let loadHandler {
            loadHandler()
        }
    }

    public func attach(child: Routing) {
        attachCallCount += 1
        if let attachHandler {
            attachHandler(child)
        }
    }

    public func detach(child: Routing) {
        detachCallCount += 1
        if let detachHandler {
            detachHandler(child)
        }
    }
}
