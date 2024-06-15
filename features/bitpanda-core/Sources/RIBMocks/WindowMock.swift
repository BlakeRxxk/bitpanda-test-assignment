//
//  WindowMock.swift
//  BitPandaCore
//

import UIKit

public class WindowMock: UIWindow {

    // MARK: Public

    public override var isKeyWindow: Bool {
        internalIsKeyWindow
    }

    public override var rootViewController: UIViewController? {
        get { internalRootViewController }
        set { internalRootViewController = newValue }
    }

    public override func makeKeyAndVisible() {
        internalIsKeyWindow = true
    }

    // MARK: Private

    private var internalIsKeyWindow = false
    private var internalRootViewController: UIViewController?
}
