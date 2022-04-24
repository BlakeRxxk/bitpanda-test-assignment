//
//  File.swift
//
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import BitPandaCore

extension Collection where Iterator.Element == Commodity {
    func mapToCellModel() -> [AssetCellModel] {
        var result: [AssetCellModel] = []

        for element in self {
            result.append(AssetCellModel(from: element))
        }

        return result
    }
}

extension Collection where Iterator.Element == Fiat {
    func mapToCellModel() -> [AssetCellModel] {
        var result: [AssetCellModel] = []

        for element in self {
            result.append(AssetCellModel(from: element))
        }

        return result
    }
}
