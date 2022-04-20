//
//  Commodity.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

struct Commodity: Codable {
    let type: Commodity.AssetType
    let attributes: Commodity.Attributes
    let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
