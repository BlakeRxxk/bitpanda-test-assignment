//
//  WalletsDetailViewModel.swift
//  WalletsFeature
//

import BitPandaCore
import Foundation

// MARK: - WalletsDetailViewModel

public final class WalletsDetailViewModel {

    // MARK: Lifecycle

    public init(
        dataPass: WalletsDetailViewDataPass,
        service: WalletsServiceProtocol) {
        title = dataPass.title
        selectedID = dataPass.selected
        type = dataPass.type
        self.service = service
    }

    // MARK: Internal

    @Published private(set) var title: String = Localized.title
    @Published private(set) var dataSource: [WalletDetailRowCellModel] = []

    func fetchWallets() {
        var data: [WalletDetailRowCellModel] = []

        switch type {
        case .fiat:
            let precision = service.fetchFiat(with: selectedID)?.attributes.precision ?? 2

            data = service.fetchFiatWallets()
                .filter { $0.attributes.fiatID == selectedID }
                .map { WalletDetailRowCellModel(from: $0, precision: precision) }
        case .cryptocoin:

            let precision = service.fetchCryptocoin(with: selectedID)?.attributes.precisionForFiatPrice ?? 4

            data = service.fetchWallets()
                .filter { $0.attributes.cryptocoinID == selectedID }
                .map { WalletDetailRowCellModel(from: $0, precision: precision) }
        case .commodity:
            let precision = service.fetchCommodity(with: selectedID)?.attributes.precisionForFiatPrice ?? 4

            data = service.fetchCommodityWallets()
                .filter { $0.attributes.cryptocoinID == selectedID }
                .map { WalletDetailRowCellModel(from: $0, precision: precision) }
        }

        dataSource = data
    }

    // MARK: Private

    private let service: WalletsServiceProtocol
    private let selectedID: String
    private let type: WalletGroupsCell.CellType
}

// MARK: WalletsDetailViewModel.Localized

extension WalletsDetailViewModel {
    fileprivate enum Localized {
        static let title = "wallets".localize()
    }
}
