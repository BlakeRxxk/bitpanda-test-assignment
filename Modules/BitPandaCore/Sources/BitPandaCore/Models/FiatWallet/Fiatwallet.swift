//
//  FiatWallet.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

struct FiatWallet: Codable {
    let type: String
    let attributes: FiatWallet.Attributes
    let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
