//
//  ComponentTests.swift
//  BitPandaCoreTests
//

import XCTest
@testable import BitPandaCore

// MARK: - ComponentTests

final class ComponentTests: XCTestCase {

    // MARK: - Tests

    func test_shared() {
        let component = TestComponent(dependency: EmptyComponent())
        XCTAssert(component.share === component.share, "Should have returned same shared object")

        XCTAssertTrue(component.share2 === component.share2)
        XCTAssertFalse(component.share === component.share2)

        XCTAssertEqual(component.callCount, 3)
    }

    func test_shared_optional() {
        let component = TestComponent(dependency: EmptyComponent())
        XCTAssert(component.optionalShare === component.expectedOptionalShare, "Should have returned same shared object")
    }
}

// MARK: - TestComponent

private final class TestComponent: Component<EmptyComponent> {

    // MARK: Internal

    private(set) var callCount = 0
    private(set) var expectedOptionalShare: ClassProtocol? = ClassProtocolImpl()

    var share: NSObject {
        callCount += 1
        return shared { NSObject() }
    }

    var share2: NSObject {
        shared { NSObject() }
    }

    // MARK: Fileprivate

    fileprivate var optionalShare: ClassProtocol? {
        shared { self.expectedOptionalShare }
    }
}

// MARK: - ClassProtocol

private protocol ClassProtocol: AnyObject {

}

// MARK: - ClassProtocolImpl

private final class ClassProtocolImpl: ClassProtocol {

}
