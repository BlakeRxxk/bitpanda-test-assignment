//
//  AssetsViewModel.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import BitPandaCore
import Foundation
import UIKit

// MARK: - AssetsViewModel

public final class AssetsViewModel {

    // MARK: Lifecycle

    public init(service: AssetsServiceProtocol) {
        self.service = service
    }

    // MARK: Public

    public func fetchAggregatedAssets() {
        var data: [AssetCellModel] = []
        data.append(contentsOf: service.fetchCryptocoins().map { AssetCellModel(from: $0) })
        data.append(contentsOf: service.fetchCommodities().map { AssetCellModel(from: $0) })
        data.append(contentsOf: service.fetchFiats().map { AssetCellModel(from: $0) })
        cache = data
        dataSource = data
    }

    public func change(scope index: SearchScope) {
        var data: [AssetCellModel] = []
        switch index {
        case .all:
            data = cache
        case .cryptocoins:
            data = cache.filter { $0.type == .cryptocoin }
        case .commodities:
            data = cache.filter { $0.type == .commodity }
        case .fiats:
            data = cache.filter { $0.type == .fiat }
        }
        dataSource = data
    }

    public func search(with text: String) {
        var data: [AssetCellModel] = []
        data = cache.filter { Fuzzy.search(needle: text, haystack: $0.title) }

        dataSource = data
    }

    // MARK: Internal

    @Published private(set) var title: String = Localized.title
    @Published private(set) var dataSource: [AssetCellModel] = []

    // MARK: Private

    private var cache: [AssetCellModel] = []

    private let service: AssetsServiceProtocol
}

// MARK: - SearchScope

public enum SearchScope: Int {
    case all
    case cryptocoins
    case commodities
    case fiats
}

extension AssetsViewModel {
    fileprivate enum Localized {
        static let title = "Assets"
    }
}
