//
//  Attributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension FiatWallet {
    struct Attributes: Codable {
        let fiatID: String
        let fiatSymbol: String
        let balance: String
        let name: String
        let pendingTransactionsCount: Int

        enum CodingKeys: String, CodingKey {
            case fiatID = "fiat_id"
            case fiatSymbol = "fiat_symbol"
            case balance
            case name
            case pendingTransactionsCount = "pending_transactions_count"
        }
    }

}
