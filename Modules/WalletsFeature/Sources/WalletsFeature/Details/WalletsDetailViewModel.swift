//
//  WalletsDetailViewModel.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

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
            data = service.fetchFiatWallets()
                .filter { $0.attributes.fiatID == selectedID }
                .map { WalletDetailRowCellModel(from: $0) }
        case .cryptocoin:
            data = service.fetchWallets()
                .filter { $0.attributes.cryptocoinID == selectedID }
                .map { WalletDetailRowCellModel(from: $0) }
        case .commodity:
            data = service.fetchCommodityWallets()
                .filter { $0.attributes.cryptocoinID == selectedID }
                .map { WalletDetailRowCellModel(from: $0) }
        }

        dataSource = data
    }

    // MARK: Private

    private let service: WalletsServiceProtocol
    private let selectedID: String
    private let type: WalletGroupsCell.CellType
}

extension WalletsDetailViewModel {
    fileprivate enum Localized {
        static let title = "Wallets"
    }
}

// MARK: - WalletsDetailViewDataPass

public struct WalletsDetailViewDataPass {
    public let title: String
    public let selected: String
    public let type: WalletGroupsCell.CellType
}
