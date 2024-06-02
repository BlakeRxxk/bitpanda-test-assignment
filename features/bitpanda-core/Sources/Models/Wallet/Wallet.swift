//
//  Wallet.swift
//  BitPandaCore
//

import Foundation

public struct Wallet: Codable {
    public var type: Wallet.WalletType
    public let attributes: Wallet.Attributes
    public let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
