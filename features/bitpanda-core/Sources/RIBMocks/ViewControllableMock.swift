//
//  ViewControllableMock.swift
//  BitPandaCore
//

import Foundation
import UIKit

public class ViewControllableMock: ViewControllable {

    // MARK: Lifecycle

    public init() { }
    public init(uiviewController: UIViewController = UIViewController()) {
        self.uiviewController = uiviewController
    }

    // MARK: Public

    public private(set) var uiviewControllerSetCallCount = 0

    public var uiviewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
}
