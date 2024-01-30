//
//  Commodity.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

public struct Commodity: Codable {
    public let type: Commodity.AssetType
    public let attributes: Commodity.Attributes
    public let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }

    public init(type: Commodity.AssetType,
                attributes: Commodity.Attributes,
                id: String) {
        self.type = type
        self.attributes = attributes
        self.id = id
    }
}
