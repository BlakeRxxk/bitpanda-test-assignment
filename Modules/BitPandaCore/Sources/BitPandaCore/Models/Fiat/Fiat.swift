//
//  Fiat.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

struct Fiat: Codable {
    let type: String
    let attributes: Fiat.Attributes
    let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
