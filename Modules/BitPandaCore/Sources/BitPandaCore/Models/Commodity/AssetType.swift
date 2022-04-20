//
//  AssetType.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Commodity {
    public enum AssetType: String, Codable {
        case commodity
        case cryptocoin
    }
}
