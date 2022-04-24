//
//  SearchScope.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import Foundation

// MARK: - SearchScope

public enum SearchScope: Int {
    case all
    case cryptocoins
    case commodities
    case fiats

    var cellType: AssetCellModel.CellType? {
        switch self {
        case .all:
            return nil
        case .cryptocoins:
            return .cryptocoin
        case .commodities:
            return .commodity
        case .fiats:
            return .fiat
        }
    }
}
