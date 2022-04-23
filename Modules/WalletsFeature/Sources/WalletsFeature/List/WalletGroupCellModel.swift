//
//  WalletGroupCellModel.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 21.04.2022.
//

import BitPandaCore
import BitPandaUI
import Foundation

// MARK: - WalletGroupCellModel

struct WalletGroupCellModel: Hashable, Equatable {
    let itemID: String
    let title: String
    let caption: String
    let type: WalletGroupsCell.CellType

    init(from model: (key: String, value: [Wallet]), isCommodity: Bool = false) {
        type = isCommodity ? .commodity : .cryptocoin
        itemID = model.key
        title = model.value.first?.attributes.cryptocoinSymbol ?? "Wallet"
        caption = "wallets: \(model.value.count)"
    }

    init(from model: (key: String, value: [FiatWallet])) {
        type = .fiat
        itemID = model.key
        title = model.value.first?.attributes.name ?? "Fiat Wallet"
        caption = "wallets: \(model.value.count)"
    }
}
