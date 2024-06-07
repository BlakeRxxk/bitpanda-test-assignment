//
//  IeoPhase.swift
//  BitPandaCore
//

import Foundation

public struct IeoPhase: Codable {
    public let type: String
    public let attributes: IeoPhase.Attributes
    public let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case attributes
        case id
    }
}
