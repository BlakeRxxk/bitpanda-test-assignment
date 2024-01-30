//
//  WalletsViewModel.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 22.04.2022.
//

import BitPandaCore
import Foundation

// MARK: - WalletsViewModel

public final class WalletsViewModel {

    // MARK: Lifecycle

    public init(service: WalletsServiceProtocol) {
        self.service = service
    }

    // MARK: Public

    public func change(scope index: SearchScope) {
        var data: [WalletGroupCellModel] = []
        selectedScope = index
        switch index {
        case .all:
            selectedScope = .all
            data = cache
        default:
            data = cache.filter { $0.type == selectedScope.cellType }
        }

        if searchString.count > 0 {
            data = data
                .filter { applySearch(for: searchString, in: $0.title) }
        }

        dataSource = data
    }

    public func search(with text: String) {
        var data: [WalletGroupCellModel] = []
        searchString = text
        data = cache

        data = data
            .filter { applySearch(for: text, in: $0.title) }

        dataSource = data
    }

    // MARK: Internal

    @Published private(set) var title: String = Localized.title
    @Published private(set) var dataSource: [WalletGroupCellModel] = []

    func fetchAggregatedWallets() {
        var data: [WalletGroupCellModel] = []
        let wallets = service.fetchWallets()
        let commodities = service.fetchCommodityWallets()
        let fiats = service.fetchFiatWallets()
        data = Dictionary(grouping: wallets, by: \.attributes.cryptocoinID)
            .sorted(by: { $0.0 < $1.0 })
            .map { WalletGroupCellModel(from: $0) }
        let commoditiesModels = Dictionary(grouping: commodities, by: \.attributes.cryptocoinID)
            .sorted(by: { $0.0 < $1.0 })
            .map { WalletGroupCellModel(from: $0, isCommodity: true) }
        data.append(contentsOf: commoditiesModels)
        let fiatModels = Dictionary(grouping: fiats, by: \.attributes.fiatID)
            .sorted(by: { $0.0 < $1.0 })
            .map { WalletGroupCellModel(from: $0) }
        data.append(contentsOf: fiatModels)
        cache = data
        dataSource = data
    }

    // MARK: Private

    private let service: WalletsServiceProtocol

    private var cache: [WalletGroupCellModel] = []
    private var selectedScope: SearchScope = .all
    private var searchString = ""

    private func applySearch(for item: String, in stack: String) -> Bool {
        Fuzzy.search(needle: item, haystack: stack)
    }
}

// MARK: WalletsViewModel.Localized

extension WalletsViewModel {
    fileprivate enum Localized {
        static let title = "wallets".localize()
    }
}
