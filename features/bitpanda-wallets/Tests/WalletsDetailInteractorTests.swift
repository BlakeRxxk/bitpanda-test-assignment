//
//  WalletsDetailInteractorTests.swift
//  BitPandaWalletsTests
//

import Foundation
import XCTest
@testable import BitPandaWallets

final class WalletsDetailInteractorTests: XCTestCase {

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
        
        presenter = WalletsDetailPresentableMock()
        router = WalletsDetailRoutingMock()
        listener = WalletsDetailListenerMock()

        interactor = WalletsDetailInteractor(walletsService: mockService, presenter: presenter)
        interactor.router = router
        interactor.listener = listener
    }

    // MARK: Private

    private var interactor: WalletsDetailInteractor!
    private var presenter: WalletsDetailPresentableMock!
    private var router: WalletsDetailRoutingMock!
    private var listener: WalletsDetailListenerMock!
    private var mockService: WalletsServiceProtocolMock!
    private var walletsFactory: WalletsFactory!
    private var cancellables = Set<AnyCancellable>()
}
