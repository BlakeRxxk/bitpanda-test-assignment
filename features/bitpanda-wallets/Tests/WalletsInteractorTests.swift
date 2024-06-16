//
//  WalletsInteractorTests.swift
//  BitPandaWalletsTests
//

import BitPandaCore
import Combine
import XCTest
@testable import BitPandaWallets

final class WalletsInteractorTests: XCTestCase {
    
    // MARK: Internal
    
    override func setUp() {
        super.setUp()
        
        mockService = WalletsServiceProtocolMock()
        walletsFactory = WalletsFactory()
        
        mockService.fetchFiatWalletsHandler = { self.walletsFactory.fetchFiatWallets() }
        mockService.fetchWalletsHandler = { self.walletsFactory.fetchWallets() }
        mockService.fetchCommodityWalletsHandler = { self.walletsFactory.fetchCommodityWallets() }
        
        mockService.fetchCommodityHandler = { self.walletsFactory.fetchCommodity(with: $0) }
        mockService.fetchCryptocoinHandler = { self.walletsFactory.fetchCryptocoin(with: $0) }
        mockService.fetchFiatHandler = { self.walletsFactory.fetchFiat(with: $0) }
        
        presenter = WalletsPresentableMock()
        router = WalletsRoutingMock()
        listener = WalletsListenerMock()
        
        interactor = WalletsInteractor(walletsService: mockService, presenter: presenter)
        interactor.router = router
        interactor.listener = listener
    }
    
    // MARK: - Tests
    
    func test_fetchAggregatedWallets_WalletsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes aggreagted data array")
        
        var values: [[WalletGroupCellModel]] = []
        
        interactor.fetchAggregatedWallets()
        
        interactor
            .dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(1, mockService.fetchWalletsCallCount)
        XCTAssertEqual(1, mockService.fetchCommodityWalletsCallCount)
        XCTAssertEqual(1, mockService.fetchFiatWalletsCallCount)
        XCTAssertEqual(values.first?.count, 4)
    }
    
    func test_changeScope_WalletsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes filtered data array")
        
        var values: [[WalletGroupCellModel]] = []
        
        interactor.fetchAggregatedWallets()
        interactor.change(scope: .fiats)
        
        interactor
            .dataSource
            .sink {
                values.append($0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(values.first?.count, 2)
    }
    
    func test_searchFiltering_WalletsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes search result data array")
        
        var values: [[WalletGroupCellModel]] = []
        
        interactor.fetchAggregatedWallets()
        interactor.search(with: "usd")
        
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
    
    
    func test_searchFilteringWithSearchScope_WalletsPresentableListener() throws {
        let expectation = XCTestExpectation(description: "Publishes search result data array")
        
        var values: [[WalletGroupCellModel]] = []
        
        interactor.fetchAggregatedWallets()
        interactor.search(with: "usd")
        interactor.change(scope: .cryptocoins)
        interactor.search(with: "")
        interactor.search(with: "usd")
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
    
    // MARK: Private
    
    private var interactor: WalletsInteractor!
    private var presenter: WalletsPresentableMock!
    private var router: WalletsRoutingMock!
    private var listener: WalletsListenerMock!
    private var mockService: WalletsServiceProtocolMock!
    private var walletsFactory: WalletsFactory!
    private var cancellables = Set<AnyCancellable>()
}
