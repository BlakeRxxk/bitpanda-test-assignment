//
//  FiatWallet.swift
//  BitPandaCore
//

import Foundation

public struct FiatWallet: Codable {
    public let type: String
    public let attributes: FiatWallet.Attributes
    public let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
