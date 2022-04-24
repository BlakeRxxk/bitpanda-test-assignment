//
//  File.swift
//
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import BitPandaCore
import Foundation
@testable import WalletsFeature

class MockWalletsService: WalletsServiceProtocol {
    public func fetchWallets() -> [Wallet] {
        let data = FileReader.readJSON(from: "WalletsMock", bundle: .module)
        return data!.data.attributes.wallets.filter { !$0.attributes.deleted }
    }

    public func fetchCommodityWallets() -> [Wallet] {
        let data = FileReader.readJSON(from: "WalletsMock", bundle: .module)
        return data!.data.attributes
            .commodityWallets
            .filter { !$0.attributes.deleted }
    }

    public func fetchFiatWallets() -> [FiatWallet] {
        let data = FileReader.readJSON(from: "WalletsMock", bundle: .module)
        return data!.data.attributes.fiatwallets
    }

    public func fetchCryptocoin(with id: String) -> Commodity? {
        let data = FileReader.readJSON(from: "WalletsMock", bundle: .module)
        return data!.data.attributes.cryptocoins.filter {
            $0.id == id
        }.first
    }

    public func fetchCommodity(with id: String) -> Commodity? {
        let data = FileReader.readJSON(from: "WalletsMock", bundle: .module)
        return data!.data.attributes.commodities.filter {
            $0.id == id
        }.first
    }

    public func fetchFiat(with id: String) -> Fiat? {
        let data = FileReader.readJSON(from: "WalletsMock", bundle: .module)
        return data!.data.attributes.fiats.filter {
            $0.id == id
        }.first
    }

}
