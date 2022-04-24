//
//  AssetsViewModelTests.swift
//  AssetsFeatureTests
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import XCTest

import Combine
@testable import AssetsFeature

final class AssetsViewModelTests: XCTestCase {

    // MARK: Internal

    func testFetchAggregatedAssets() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes aggreagted data array")

        var values: [[AssetCellModel]] = []

        sut.fetchAggregatedAssets()

        sut
            .$dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 3)
    }

    func testScopeFiltering() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes filtered data array")

        var values: [[AssetCellModel]] = []

        sut.fetchAggregatedAssets()
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

    func testSearchFiltering() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Publishes search result data array")

        var values: [[AssetCellModel]] = []

        sut.fetchAggregatedAssets()
        sut.search(with: "btc")

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

        var values: [[AssetCellModel]] = []

        sut.fetchAggregatedAssets()
        sut.search(with: "btc")
        sut.change(scope: .cryptocoins)
        sut.search(with: "")
        sut.search(with: "btc")
        sut.change(scope: .fiats)

        sut
            .$dataSource
            .sink {
                values.append($0)

                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values, [[]])
    }

    // MARK: Private

    private var cancellables = Set<AnyCancellable>()

    private func makeSUT() -> AssetsViewModel {
        let mockService = MockAssetsService()
        let sut = AssetsViewModel(service: mockService)
        return sut
    }
}
