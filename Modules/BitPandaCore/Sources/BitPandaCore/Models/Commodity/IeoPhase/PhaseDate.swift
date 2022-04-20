//
//  PhaseDate.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
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
