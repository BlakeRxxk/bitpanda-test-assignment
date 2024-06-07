//
//  RouterTests.swift
//  BitPandaCoreTests
//

import Combine
import XCTest
@testable import BitPandaCore
// swiftlint:disable implicitly_unwrapped_optional
final class RouterTests: XCTestCase {

    // MARK: Internal

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        router = Router(interactor: InteractableMock())
    }

    override func tearDown() {
        super.tearDown()

        lifecycleCancellable.cancel()
    }

    // MARK: - Tests

    func test_load_verifyLifecycleObservable() {
        var currentLifecycle: RouterLifecycle?
        var didComplete = false
        lifecycleCancellable = router
            .lifecycle
            .sink(receiveCompletion: { _ in
                currentLifecycle = nil
                didComplete = true
            }, receiveValue: { lifecycle in
                currentLifecycle = lifecycle
            })

        XCTAssertNil(currentLifecycle)
        XCTAssertFalse(didComplete)

        router.load()

        XCTAssertEqual(currentLifecycle, RouterLifecycle.didLoad)
        XCTAssertFalse(didComplete)

        router = nil

        XCTAssertNil(currentLifecycle)
        XCTAssertTrue(didComplete)
    }

    // MARK: Private

    private var router: Router<Interactable>!
    private var lifecycleCancellable: AnyCancellable!
}
