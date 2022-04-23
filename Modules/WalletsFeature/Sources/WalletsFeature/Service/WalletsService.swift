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
}

// MARK: - WalletsService

public class WalletsService: WalletsServiceProtocol {

    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func fetchWallets() -> [Wallet] {
        let data = FileReader.readJSON(from: "Masterdata")
        return data!.data.attributes.wallets.filter { !$0.attributes.deleted }
    }

    public func fetchCommodityWallets() -> [Wallet] {
        let data = FileReader.readJSON(from: "Masterdata")
        return data!.data.attributes
            .commodityWallets
            .filter { !$0.attributes.deleted }
    }

    public func fetchFiatWallets() -> [FiatWallet] {
        let data = FileReader.readJSON(from: "Masterdata")
        return data!.data.attributes.fiatwallets
    }
}
