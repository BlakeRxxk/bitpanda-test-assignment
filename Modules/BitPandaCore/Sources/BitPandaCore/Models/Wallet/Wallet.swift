//
//  Wallet.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

public struct Wallet: Codable {
    public let type: Wallet.WalletType
    public let attributes: Wallet.Attributes
    public let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
