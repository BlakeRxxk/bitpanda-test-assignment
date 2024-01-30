//
//  AssetCellModel.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 21.04.2022.
//

import BitPandaCore
import BitPandaUI
import Foundation

// MARK: - AssetCellModel

public struct AssetCellModel: Hashable, Equatable, Identifiable {

    // MARK: Lifecycle

    public init(from model: Commodity) {
        id = model.id
        type = CellType(rawValue: model.type.rawValue) ?? .cryptocoin
        title = model.attributes.name
        caption = model.attributes.symbol
        lightLogo = URL(string: model.attributes.logo)
        darkLogo = URL(string: model.attributes.logoDark)
        amount = NumberFactory
            .rawToMoneyString(
                value: model.attributes.avgPrice,
                precision: model.attributes.precisionForFiatPrice)
    }

    public init(from model: Fiat) {
        id = model.id
        type = .fiat
        title = model.attributes.name
        caption = model.attributes.symbol
        lightLogo = URL(string: model.attributes.logoWhite)
        darkLogo = URL(string: model.attributes.logoDark)
        amount = NumberFactory
            .rawToMoneyString(
                value: model.attributes.toEurRate,
                precision: model.attributes.precision)
    }

    // MARK: Public

    public let id: String
    public let type: AssetCellModel.CellType
    public let title: String
    public let caption: String?
    public let lightLogo: URL?
    public let darkLogo: URL?
    public let amount: String
}

// MARK: AssetCellModel.CellType

extension AssetCellModel {
    public enum CellType: String {
        case commodity
        case cryptocoin
        case fiat
    }
}
