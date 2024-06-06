//
//  Collection+Ext.swift
//  BitPandaAssets
//

import BitPandaCore

extension Collection where Element == Commodity {
    func mapToCellModel() -> [AssetCellModel] {
        var result: [AssetCellModel] = []

        for element in self {
            result.append(AssetCellModel(from: element))
        }

        return result
    }
}

extension Collection where Element == Fiat {
    func mapToCellModel() -> [AssetCellModel] {
        var result: [AssetCellModel] = []

        for element in self {
            result.append(AssetCellModel(from: element))
        }

        return result
    }
}
