//
//  WalletDetailRowCellModel.swift
//  WalletsFeature
//

import BitPandaCore
import Foundation

// MARK: - WalletDetailRowCellModel

public struct WalletDetailRowCellModel: Hashable, Equatable {

    // MARK: Lifecycle

    public init(from model: Wallet, precision: Int) {
        title = model.attributes.name
        caption = "\(Localized.caption) \(model.attributes.pendingTransactionsCount)"
        amount = NumberFactory
            .rawToMoneyString(
                value: model.attributes.balance,
                precision: precision,
                currencyCode: model.attributes.cryptocoinSymbol)
        isDefault = model.attributes.isDefault
    }

    public init(from model: FiatWallet, precision: Int) {
        title = model.attributes.name
        caption = "\(Localized.caption) \(model.attributes.pendingTransactionsCount)"
        amount = NumberFactory
            .rawToMoneyString(
                value: model.attributes.balance,
                precision: precision,
                currencyCode: model.attributes.fiatSymbol)
        isDefault = false
    }

    // MARK: Public

    public let title: String
    public let caption: String
    public let amount: String
    public let isDefault: Bool
}

// MARK: WalletDetailRowCellModel.Localized

extension WalletDetailRowCellModel {
    fileprivate enum Localized {
        static let caption = "pending".localize()
    }
}
