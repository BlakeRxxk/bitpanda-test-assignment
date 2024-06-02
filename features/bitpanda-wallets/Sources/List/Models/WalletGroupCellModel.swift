//
//  WalletGroupCellModel.swift
//  WalletsFeature
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
        title = model.value.first?.attributes.cryptocoinSymbol ?? Localized.fallbackTitle
        let caption = isCommodity ? Localized.commodity : Localized.cryptocoin
        self.caption = "\(caption). \(Localized.caption) \(model.value.count)"
    }

    init(from model: (key: String, value: [FiatWallet])) {
        type = .fiat
        itemID = model.key
        title = model.value.first?.attributes.name ?? Localized.fallbackFiatTitle
        caption = "\(Localized.commodity). \(Localized.caption) \(model.value.count)"
    }
}

// MARK: WalletGroupCellModel.Localized

extension WalletGroupCellModel {
    fileprivate enum Localized {
        static let fallbackTitle = "wallet".localize()
        static let fallbackFiatTitle = "fiatWallet".localize()
        static let caption = "wallets".localize()

        static let cryptocoin = "cryptocoin".localize()
        static let commodity = "commodity".localize()
        static let fiat = "fiat".localize()
    }
}
