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
        data.append(contentsOf: service.fetchCryptocoins().mapToCellModel())
        data.append(contentsOf: service.fetchCommodities().mapToCellModel())
        data.append(contentsOf: service.fetchFiats().mapToCellModel())
        cache = data
        dataSource = data
    }

    public func change(scope index: SearchScope) {
        var data: [AssetCellModel] = []
        selectedScope = index
        switch index {
        case .all:
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
        var data: [AssetCellModel] = []
        searchString = text
        data = cache

        if selectedScope != .all {
            data = data
                .filter { $0.type == selectedScope.cellType }
        }

        data = data
            .filter { applySearch(for: text, in: $0.title) }

        dataSource = data
    }

    // MARK: Internal

    @Published private(set) var title: String = Localized.title
    @Published private(set) var dataSource: [AssetCellModel] = []

    // MARK: Private

    private var cache: [AssetCellModel] = []
    private var selectedScope: SearchScope = .all
    private var searchString = ""
    private let service: AssetsServiceProtocol

    private func applySearch(for item: String, in stack: String) -> Bool {
        Fuzzy.search(needle: item, haystack: stack)
    }
}

// MARK: AssetsViewModel.Localized

extension AssetsViewModel {
    fileprivate enum Localized {
        static let title = "assets".localize()
    }
}
