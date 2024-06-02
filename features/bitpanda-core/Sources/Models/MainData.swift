//
//  MainData.swift
//  BitPandaCore
//

import Foundation

// MARK: - MainDataWrapper

public struct MainDataWrapper: Codable {
    public let data: MainData

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - MainData

public struct MainData: Codable {
    public let type: String
    public let attributes: Attributes

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
    }
}

// MARK: - Attributes

public struct Attributes: Codable {
    public let cryptocoins: [Commodity]
    public let commodities: [Commodity]
    public let fiats: [Fiat]
    public let wallets: [Wallet]
    public let commodityWallets: [Wallet]
    public let fiatwallets: [FiatWallet]

    enum CodingKeys: String, CodingKey {
        case cryptocoins
        case commodities
        case fiats
        case wallets
        case commodityWallets = "commodity_wallets"
        case fiatwallets
    }
}
