//
//  WalletsViewModel.swift
//  WalletsFeature
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
        selectedScope = index
        applyFilter()
    }

    public func search(with text: String) {
        searchString = text
        applyFilter()
    }

    // MARK: Internal

    @Published private(set) var title: String = Localized.title
    @Published private(set) var dataSource: [WalletGroupCellModel] = []

    func fetchAggregatedWallets() {
        let wallets = service
            .fetchWallets()
            .group(by: \.attributes.cryptocoinID)
            .map { WalletGroupCellModel(from: $0) }

        let commodities = service
            .fetchCommodityWallets()
            .group(by: \.attributes.cryptocoinID)
            .map { WalletGroupCellModel(from: $0, isCommodity: true) }

        let fiats = service
            .fetchFiatWallets()
            .group(by: \.attributes.fiatID)
            .map { WalletGroupCellModel(from: $0) }

        let result = wallets + commodities + fiats
        cache = result
        dataSource = result
    }

    // MARK: Private

    private let service: WalletsServiceProtocol

    private var cache: [WalletGroupCellModel] = []
    private var selectedScope: SearchScope = .all
    private var searchString = ""

    private func applyFilter() {
        var data: [WalletGroupCellModel] = cache

        if selectedScope != .all {
            data = data.filter { $0.type == selectedScope.cellType }
        }

        if !searchString.isEmpty {
            data = data.filter { applySearch(for: searchString, in: $0.title) }
        }

        dataSource = data
    }

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
