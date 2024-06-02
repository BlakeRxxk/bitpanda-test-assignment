//
//  PhaseDate.swift
//  BitPandaCore
//

import Foundation

extension IeoPhase {
    public struct PhaseDate: Codable {
        public let dateIso8601: String
        public let unix: String

        enum CodingKeys: String, CodingKey {
            case dateIso8601 = "date_iso8601"
            case unix
        }
    }
}
