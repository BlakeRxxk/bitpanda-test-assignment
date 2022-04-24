//
//  WalletsViewModelTests.swift
//  WalletsFeatureTests
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import Combine
import XCTest
@testable import WalletsFeature

final class WalletsViewModelTests: XCTestCase {

    // MARK: Internal

    func testFetchAggregatedWallets() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes aggreagted data array")

        var values: [[WalletGroupCellModel]] = []

        sut.fetchAggregatedWallets()

        sut
            .$dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 4)
    }

    func testScopeFiltering() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes filtered data array")

        var values: [[WalletGroupCellModel]] = []

        sut.fetchAggregatedWallets()
        sut.change(scope: .fiats)

        sut
            .$dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 2)
    }

    func testSearchFiltering() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes search result data array")

        var values: [[WalletGroupCellModel]] = []

        sut.fetchAggregatedWallets()
        sut.search(with: "usd")

        sut
            .$dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 1)
    }

    func testSearchAndScopeFiltering() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes search result data array")

        var values: [[WalletGroupCellModel]] = []

        sut.fetchAggregatedWallets()
        sut.search(with: "usd")
        sut.change(scope: .cryptocoins)
        sut.search(with: "")
        sut.search(with: "usd")
        sut.change(scope: .fiats)

        sut
            .$dataSource
            .sink {
                values.append($0)

                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 1)
    }

    // MARK: Private

    private var cancellables = Set<AnyCancellable>()

    private func makeSUT() -> WalletsViewModel {
        let mockService = MockWalletsService()
        let sut = WalletsViewModel(service: mockService)
        return sut
    }
}
