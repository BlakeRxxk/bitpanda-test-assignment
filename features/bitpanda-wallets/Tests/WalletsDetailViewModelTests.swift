//
//  WalletsDetailViewModelTests.swift
//  WalletsFeatureTests
//

import Combine
import XCTest
@testable import BitPandaWallets

final class WalletsDetailViewModelTests: XCTestCase {

    // MARK: Internal

    func testFetchWalletsCommodity() throws {
        let sut = makeSUT(with: .init(title: "XPT", selected: "36", type: .commodity))
        let expectation = XCTestExpectation(description: "Publishes wallets data array")

        var values: [[WalletDetailRowCellModel]] = []

        sut.fetchWallets()

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

    func testFetchWalletsCryptocoin() throws {
        let sut = makeSUT(with: .init(title: "BTC", selected: "1", type: .cryptocoin))
        let expectation = XCTestExpectation(description: "Publishes wallets data array")

        var values: [[WalletDetailRowCellModel]] = []

        sut.fetchWallets()

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

    func testFetchWalletsFiat() throws {
        let sut = makeSUT(with: .init(title: "EUR", selected: "1", type: .fiat))
        let expectation = XCTestExpectation(description: "Publishes wallets data array")

        var values: [[WalletDetailRowCellModel]] = []

        sut.fetchWallets()

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

    private func makeSUT(with dataPass: WalletsDetailViewDataPass) -> WalletsDetailViewModel {
        let mockService = MockWalletsService()
        let sut = WalletsDetailViewModel(dataPass: dataPass, service: mockService)
        return sut
    }
}
