//
//  WalletDetailRowCellModel.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import BitPandaCore
import Foundation

// MARK: - WalletDetailRowCellModel

struct WalletDetailRowCellModel: Hashable, Equatable {

    // MARK: Lifecycle

    init(from model: Wallet, precision: Int) {
        title = model.attributes.name
        caption = "\(Localized.caption) \(model.attributes.pendingTransactionsCount)"
        amount = NumberFactory
            .rawToMoneyString(
                value: model.attributes.balance,
                precision: precision,
                currencyCode: model.attributes.cryptocoinSymbol)
        isDefault = model.attributes.isDefault
    }

    init(from model: FiatWallet, precision: Int) {
        title = model.attributes.name
        caption = "\(Localized.caption) \(model.attributes.pendingTransactionsCount)"
        amount = NumberFactory
            .rawToMoneyString(
                value: model.attributes.balance,
                precision: precision,
                currencyCode: model.attributes.fiatSymbol)
        isDefault = false
    }

    // MARK: Internal

    let title: String
    let caption: String
    let amount: String
    let isDefault: Bool
}

// MARK: WalletDetailRowCellModel.Localized

extension WalletDetailRowCellModel {
    fileprivate enum Localized {
        static let caption = "pending".localize()
    }
}
