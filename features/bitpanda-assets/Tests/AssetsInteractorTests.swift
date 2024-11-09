//
//  AssetsInteractorTests.swift
//  BitPandaAssetsTests
//

import BitPandaCore
import Combine
import XCTest
@testable import BitPandaAssets

// swiftlint:disable implicitly_unwrapped_optional
final class AssetsInteractorTests: XCTestCase {

    // MARK: Internal

    override func setUp() {
        super.setUp()
        mockService = AssetsServiceProtocolMock()
        assetsFactory = AssetsFactory()

        mockService.fetchCommoditiesHandler = { self.assetsFactory.fetchCommodities() }
        mockService.fetchCryptocoinsHandler = { self.assetsFactory.fetchCryptocoins() }
        mockService.fetchFiatsHandler = { self.assetsFactory.fetchFiats() }

        presenter = AssetsPresentableMock()
        router = AssetsRoutingMock()
        listener = AssetsListenerMock()

        interactor = AssetsInteractor(assetsService: mockService, presenter: presenter)
        interactor.router = router
        interactor.listener = listener
    }

    // MARK: - Tests

    func test_fetchAggregatedAssets_AssetsPresentableListener() throws {
        var values: [[AssetCellModel]] = []

        let expectation = XCTestExpectation(description: "Publishes aggreagted data array")

        interactor.fetchAggregatedAssets()

        interactor
            .dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(1, mockService.fetchCommoditiesCallCount)
        XCTAssertEqual(1, mockService.fetchCryptocoinsCallCount)
        XCTAssertEqual(1, mockService.fetchFiatsCallCount)
        XCTAssertEqual(values.first?.count, 3)
    }

    func test_changeScope_AssetsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes filtered data array")

        var values: [[AssetCellModel]] = []

        interactor.fetchAggregatedAssets()
        interactor.change(scope: .fiats)

        interactor
            .dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 1)
    }

    func test_searchFiltering_AssetsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes search result data array")

        var values: [[AssetCellModel]] = []

        interactor.fetchAggregatedAssets()
        interactor.search(with: "btc")

        interactor
            .dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values.first?.count, 1)
    }

    func test_searchFilteringWithSearchScope_AssetsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes search result data array")

        var values: [[AssetCellModel]] = []

        interactor.fetchAggregatedAssets()
        interactor.search(with: "btc")
        interactor.change(scope: .cryptocoins)
        interactor.search(with: "")
        interactor.search(with: "btc")
        interactor.change(scope: .fiats)

        interactor
            .dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(values, [[]])
    }

    // MARK: Private

    private var interactor: AssetsInteractor!
    private var presenter: AssetsPresentableMock!
    private var router: AssetsRoutingMock!
    private var listener: AssetsListenerMock!
    private var mockService: AssetsServiceProtocolMock!
    private var assetsFactory: AssetsFactory!
    private var cancellables = Set<AnyCancellable>()
}
