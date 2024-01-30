//
//  Fiat.swift
//  BitPandaCore
//

import Foundation

public struct Fiat: Codable {
    public let type: String
    public let attributes: Fiat.Attributes
    public let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
