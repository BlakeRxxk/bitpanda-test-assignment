//
//  AssetGroup.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Commodity {
    public enum AssetGroup: String, Codable {
        case coin
        case metal
    }
}
