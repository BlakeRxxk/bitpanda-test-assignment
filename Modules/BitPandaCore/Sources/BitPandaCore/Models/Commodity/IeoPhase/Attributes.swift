//
//  Attributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension IeoPhase {
    struct Attributes: Codable {
        let name: String
        let phaseNumber: Int
        let startDate: IeoPhase.PhaseDate
        let endDate: IeoPhase.PhaseDate
        let maxStock: String
        let price: String
        let active: Bool

        enum CodingKeys: String, CodingKey {
            case name
            case phaseNumber = "phase_number"
            case startDate = "start_date"
            case endDate = "end_date"
            case maxStock = "max_stock"
            case price
            case active
        }
    }
}
