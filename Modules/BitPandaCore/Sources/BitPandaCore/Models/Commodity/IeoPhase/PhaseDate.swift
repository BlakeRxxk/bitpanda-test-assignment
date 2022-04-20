//
//  PhaseDate.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension IeoPhase {
    struct PhaseDate: Codable {
        let dateIso8601: Date
        let unix: String

        enum CodingKeys: String, CodingKey {
            case dateIso8601 = "date_iso8601"
            case unix
        }
    }
}
