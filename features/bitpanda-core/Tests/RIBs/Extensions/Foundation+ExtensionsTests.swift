//
//  Foundation+ExtensionsTests.swift
//  BitPandaCoreTests
//

import XCTest
@testable import BitPandaCore

final class FoundationExtensionsTests: XCTestCase {

    // MARK: - Tests

    func test_removeElementByReference() {
        let object1 = NSObject()
        let object2 = NSObject()
        let object3 = NSObject()

        var array = [object1, object2]
        XCTAssert(array.count == 2)

        array.removeElementByReference(object1)
        XCTAssert(array.count == 1)

        array.removeElementByReference(object3)
        XCTAssert(array.count == 1)

        array.removeElementByReference(object2)
        XCTAssert(array.isEmpty)
    }
}
