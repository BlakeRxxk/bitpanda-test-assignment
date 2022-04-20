//
//  MainData.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

// MARK: - MainData

struct MainData {
    let type: String
    let attributes: Attributes
}

// MARK: - Attributes

struct Attributes: Codable {
    let cryptocoins: [Commodity]
    let commodities: [Commodity]
    let fiats: [Fiat]
    let wallets: [Wallet]
    let commodityWallets: [Wallet]
    let fiatwallets: [FiatWallet]

    enum CodingKeys: String, CodingKey {
        case cryptocoins
        case commodities
        case fiats
        case wallets
        case commodityWallets = "commodity_wallets"
        case fiatwallets
    }
}
