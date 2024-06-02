//
//  SearchScope.swift
//  AssetsFeature
//

import BitPandaCore
import Foundation
// MARK: - SearchScope

public enum SearchScope: Int, CaseIterable {
    case all
    case cryptocoins
    case commodities
    case fiats

    // MARK: Internal

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

    var title: String {
        switch self {
        case .all:
            return "all".localize()
        case .cryptocoins:
            return "cryptocoins".localize()
        case .commodities:
            return "commodities".localize()
        case .fiats:
            return "fiats".localize()
        }
    }
}
