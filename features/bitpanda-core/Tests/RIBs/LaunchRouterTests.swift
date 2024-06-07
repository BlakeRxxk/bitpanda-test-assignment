//
//  LaunchRouterTests.swift
//  BitPandaCoreTests
//

import XCTest
@testable import BitPandaCore
// swiftlint:disable implicitly_unwrapped_optional
final class LaunchRouterTests: XCTestCase {

    // MARK: Internal

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        interactor = InteractableMock()
        viewController = ViewControllableMock()
        launchRouter = LaunchRouter(interactor: interactor, viewController: viewController)
    }

    // MARK: - Tests

    func test_launchFromWindow() {
        let window = WindowMock(frame: .zero)
        launchRouter.launch(from: window)

        XCTAssert(window.rootViewController === viewController.uiviewController)
        XCTAssert(window.isKeyWindow)
    }

    // MARK: Private

    private var launchRouter: LaunchRouting!

    private var interactor: InteractableMock!
    private var viewController: ViewControllableMock!

}
