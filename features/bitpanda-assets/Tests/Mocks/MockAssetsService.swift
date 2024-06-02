//
//  MockAssetsService.swift
//  AssetsFeatureTests
//

import BitPandaCore
import Foundation
@testable import AssetsFeature

class MockAssetsService: AssetsServiceProtocol {
    func fetchCryptocoins() -> [Commodity] {
        guard let data = FileReader.readJSON(from: "AssetsMock", bundle: .module) else { return [] }
        return data.data.attributes.cryptocoins
    }

    func fetchCommodities() -> [Commodity] {
        guard let data = FileReader.readJSON(from: "AssetsMock", bundle: .module) else { return [] }
        return data.data.attributes.commodities
    }

    func fetchFiats() -> [Fiat] {
        guard let data = FileReader.readJSON(from: "AssetsMock", bundle: .module) else { return [] }
        return data.data.attributes.fiats.filter { $0.attributes.hasWallets }
    }
}
