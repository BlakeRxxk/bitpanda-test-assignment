//
//  SearchScope.swift
//  WalletsFeature
//

import Foundation

// MARK: - SearchScope

public enum SearchScope: Int {
    case all
    case cryptocoins
    case commodities
    case fiats

    var cellType: WalletGroupsCell.CellType? {
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
