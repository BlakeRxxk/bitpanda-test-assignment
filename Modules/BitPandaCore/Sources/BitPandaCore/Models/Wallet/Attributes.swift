//
//  Attributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Wallet {
    struct Attributes: Codable {
        let cryptocoinID: String
        let cryptocoinSymbol: String
        let balance: String
        let isDefault: Bool
        let name: String
        let pendingTransactionsCount: Int
        let deleted: Bool

        enum CodingKeys: String, CodingKey {
            case cryptocoinID = "cryptocoin_id"
            case cryptocoinSymbol = "cryptocoin_symbol"
            case balance
            case isDefault = "is_default"
            case name
            case pendingTransactionsCount = "pending_transactions_count"
            case deleted
        }
    }

}
