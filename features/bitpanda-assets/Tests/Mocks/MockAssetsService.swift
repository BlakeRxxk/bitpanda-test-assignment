//
//  MockAssetsService.swift
//  AssetsFeatureTests
//

import BitPandaAssets
import BitPandaCore
import Foundation

// MARK: - AssetsFactory

class AssetsFactory: AssetsServiceProtocol {
    func fetchCryptocoins() -> [Commodity] {
        guard let data = FileReader.readJSON(from: "AssetsMock", bundle: .framework) else { return [] }
        return data.data.attributes.cryptocoins
    }

    func fetchCommodities() -> [Commodity] {
        guard let data = FileReader.readJSON(from: "AssetsMock", bundle: .framework) else { return [] }
        return data.data.attributes.commodities
    }

    func fetchFiats() -> [Fiat] {
        guard let data = FileReader.readJSON(from: "AssetsMock", bundle: .framework) else { return [] }
        return data.data.attributes.fiats.filter { $0.attributes.hasWallets }
    }
}

extension Bundle {

    // MARK: Public

    public static var framework: Bundle {
        Bundle(for: Class.self)
    }

    public var releaseVersionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    public var buildVersionNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    // MARK: Internal

    final class Class {}
}
