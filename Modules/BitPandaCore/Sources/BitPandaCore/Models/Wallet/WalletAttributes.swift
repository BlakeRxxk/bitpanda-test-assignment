//
//  WalletAttributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Wallet {
    public struct Attributes: Codable {
        public let cryptocoinID: String
        public let cryptocoinSymbol: String
        public let balance: String
        public let isDefault: Bool
        public let name: String
        public let pendingTransactionsCount: Int
        public let deleted: Bool

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
