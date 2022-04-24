//
//  MockAssetsService.swift
//  AssetsFeatureTests
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import BitPandaCore
import Foundation
@testable import AssetsFeature

class MockAssetsService: AssetsServiceProtocol {
    func fetchCryptocoins() -> [Commodity] {
        let data = FileReader.readJSON(from: "AssetsMock", bundle: .module)
        return data!.data.attributes.cryptocoins
    }

    func fetchCommodities() -> [Commodity] {
        let data = FileReader.readJSON(from: "AssetsMock", bundle: .module)
        return data!.data.attributes.commodities
    }

    func fetchFiats() -> [Fiat] {
        let data = FileReader.readJSON(from: "AssetsMock", bundle: .module)
        return data!.data.attributes.fiats.filter { $0.attributes.hasWallets }
    }
}
