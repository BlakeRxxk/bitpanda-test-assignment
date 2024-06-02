//
//  MockWalletsService.swift
//  WalletsFeatureTests
//

import BitPandaCore
import Foundation
@testable import BitPandaWallets

class MockWalletsService: WalletsServiceProtocol {
    public func fetchWallets() -> [Wallet] {
        guard let data = FileReader.readJSON(from: "WalletsMock", bundle: .module) else { return [] }
        return data.data.attributes.wallets.filter { !$0.attributes.deleted }
    }

    public func fetchCommodityWallets() -> [Wallet] {
        guard let data = FileReader.readJSON(from: "WalletsMock", bundle: .module) else { return [] }
        return data.data.attributes
            .commodityWallets
            .filter { !$0.attributes.deleted }
    }

    public func fetchFiatWallets() -> [FiatWallet] {
        guard let data = FileReader.readJSON(from: "WalletsMock", bundle: .module) else { return [] }
        return data.data.attributes.fiatwallets
    }

    public func fetchCryptocoin(with id: String) -> Commodity? {
        guard let data = FileReader.readJSON(from: "WalletsMock", bundle: .module) else { return nil }
        return data.data.attributes.cryptocoins.filter {
            $0.id == id
        }.first
    }

    public func fetchCommodity(with id: String) -> Commodity? {
        guard let data = FileReader.readJSON(from: "WalletsMock", bundle: .module) else { return nil }
        return data.data.attributes.commodities.filter {
            $0.id == id
        }.first
    }

    public func fetchFiat(with id: String) -> Fiat? {
        guard let data = FileReader.readJSON(from: "WalletsMock", bundle: .module) else { return nil }
        return data.data.attributes.fiats.filter {
            $0.id == id
        }.first
    }

}
