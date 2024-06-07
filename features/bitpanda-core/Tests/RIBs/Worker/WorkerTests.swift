//
//  WorkerTests.swift
//  BitPandaCoreTests
//

import Combine
import XCTest
@testable import BitPandaCore

// MARK: - WorkerTests

// swiftlint:disable implicitly_unwrapped_optional
final class WorkerTests: XCTestCase {

    // MARK: Internal

    override func setUp() {
        super.setUp()

        cancellables = []

        worker = TestWorker()
        interactor = InteractorMock()
    }

    // MARK: - Tests

    func test_didStart_onceOnly_boundToInteractor() {
        XCTAssertEqual(worker.didStartCallCount, 0)
        XCTAssertEqual(worker.didStopCallCount, 0)

        worker.start(interactor)

        XCTAssertTrue(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 0)
        XCTAssertEqual(worker.didStopCallCount, 0)

        interactor.activate()

        XCTAssertTrue(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 1)
        XCTAssertEqual(worker.didStopCallCount, 0)

        interactor.deactivate()

        XCTAssertTrue(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 1)
        XCTAssertEqual(worker.didStopCallCount, 1)

        worker.start(interactor)

        XCTAssertTrue(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 1)
        XCTAssertEqual(worker.didStopCallCount, 1)

        interactor.activate()

        XCTAssertTrue(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 2)
        XCTAssertEqual(worker.didStopCallCount, 1)

        worker.stop()

        XCTAssertFalse(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 2)
        XCTAssertEqual(worker.didStopCallCount, 2)

        worker.stop()

        XCTAssertFalse(worker.isStarted)
        XCTAssertEqual(worker.didStartCallCount, 2)
        XCTAssertEqual(worker.didStopCallCount, 2)
    }

    func test_start_stop_lifecycle() {
        worker.isStartedPublisher
            .prefix(1)
            .sink { XCTAssertFalse($0) }
            .store(in: &cancellables)

        interactor.activate()
        worker.start(interactor)

        worker.isStartedPublisher
            .prefix(1)
            .sink { XCTAssertTrue($0) }
            .store(in: &cancellables)

        worker.stop()

        worker.isStartedPublisher
            .prefix(1)
            .sink { XCTAssertFalse($0) }
            .store(in: &cancellables)
    }

    // MARK: Private

    private var worker: TestWorker!
    private var interactor: InteractorMock!
    private var cancellables: Set<AnyCancellable>!
}

// MARK: - TestWorker

private final class TestWorker: Worker {

    private(set) var didStartCallCount = 0
    private(set) var didStopCallCount = 0

    // MARK: - Overrides

    override func didStart(_ scope: InteractorScope) {
        super.didStart(scope)

        didStartCallCount += 1
    }

    override func didStop() {
        super.didStop()

        didStopCallCount += 1
    }
}
