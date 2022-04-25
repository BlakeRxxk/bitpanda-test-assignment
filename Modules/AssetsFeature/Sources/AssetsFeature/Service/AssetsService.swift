//
//  AssetsService.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 21.04.2022.
//

import BitPandaCore
import Foundation

// MARK: - AssetsServiceProtocol

public protocol AssetsServiceProtocol {
    func fetchCryptocoins() -> [Commodity]
    func fetchCommodities() -> [Commodity]
    func fetchFiats() -> [Fiat]
}

// MARK: - AssetsService

public class AssetsService: AssetsServiceProtocol {

    // MARK: Lifecycle

    public init () {}

    // MARK: Public

    public func fetchCryptocoins() -> [Commodity] {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return [] }
        return data.data.attributes.cryptocoins
    }

    public func fetchCommodities() -> [Commodity] {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return [] }
        return data.data.attributes.commodities
    }

    public func fetchFiats() -> [Fiat] {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return [] }
        return data.data.attributes.fiats.filter { $0.attributes.hasWallets }
    }
}
