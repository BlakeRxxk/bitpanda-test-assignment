//
//  WalletsService.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import BitPandaCore

// MARK: - WalletsServiceProtocol

public protocol WalletsServiceProtocol {
    func fetchWallets() -> [Wallet]
    func fetchCommodityWallets() -> [Wallet]
    func fetchFiatWallets() -> [FiatWallet]

    func fetchCommodity(with id: String) -> Commodity?
    func fetchCryptocoin(with id: String) -> Commodity?
    func fetchFiat(with id: String) -> Fiat?
}

// MARK: - WalletsService

public class WalletsService: WalletsServiceProtocol {

    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func fetchWallets() -> [Wallet] {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return [] }
        return data.data.attributes.wallets.filter { !$0.attributes.deleted }
    }

    public func fetchCommodityWallets() -> [Wallet] {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return [] }
        return data.data.attributes
            .commodityWallets
            .filter { !$0.attributes.deleted }
    }

    public func fetchFiatWallets() -> [FiatWallet] {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return [] }
        return data.data.attributes.fiatwallets
    }

    public func fetchCryptocoin(with id: String) -> Commodity? {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return nil }
        return data.data.attributes.cryptocoins.filter {
            $0.id == id
        }.first
    }

    public func fetchCommodity(with id: String) -> Commodity? {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return nil }
        return data.data.attributes.commodities.filter {
            $0.id == id
        }.first
    }

    public func fetchFiat(with id: String) -> Fiat? {
        guard let data = FileReader.readJSON(from: "Masterdata") else { return nil }
        return data.data.attributes.fiats.filter {
            $0.id == id
        }.first
    }
}
