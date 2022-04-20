//
//  FiatWallet.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
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
