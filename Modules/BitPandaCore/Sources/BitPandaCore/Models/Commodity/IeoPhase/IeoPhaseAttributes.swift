//
//  IeoPhaseAttributes.swift
//  BitPandaCore
//

import Foundation

extension IeoPhase {
    public struct Attributes: Codable {
        public let name: String
        public let phaseNumber: Int
        public let startDate: IeoPhase.PhaseDate
        public let endDate: IeoPhase.PhaseDate
        public let maxStock: String
        public let price: String
        public let active: Bool

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
