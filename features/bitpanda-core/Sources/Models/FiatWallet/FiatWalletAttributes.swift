//
//  FiatWalletAttributes.swift
//  BitPandaCore
//

import Foundation

extension FiatWallet {
    public struct Attributes: Codable {
        public let fiatID: String
        public let fiatSymbol: String
        public let balance: String
        public let name: String
        public let pendingTransactionsCount: Int

        enum CodingKeys: String, CodingKey {
            case fiatID = "fiat_id"
            case fiatSymbol = "fiat_symbol"
            case balance
            case name
            case pendingTransactionsCount = "pending_transactions_count"
        }
    }

}
