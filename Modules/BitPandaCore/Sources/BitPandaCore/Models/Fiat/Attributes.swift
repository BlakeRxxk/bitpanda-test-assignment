//
//  Attributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Fiat {
    struct Attributes: Codable {
        enum CodingKeys: String, CodingKey {
            case symbol
            case name
            case precision
            case toEurRate = "to_eur_rate"
            case defaultSellAmount = "default_sell_amount"
            case numericCharacterReference = "numeric_character_reference"
            case minWithdrawEuro = "min_withdraw_euro"
            case symbolCharacter = "symbol_character"
            case hasWallets = "has_wallets"
            case logo
            case logoDark = "logo_dark"
            case logoWhite = "logo_white"
            case logoColor = "logo_color"
            case nameDeu = "name_deu"
            case nameEng = "name_eng"
            case nameFra = "name_fra"
        }

        let symbol: String
        let name: String
        let precision: Int
        let toEurRate: String
        let defaultSellAmount: String
        let numericCharacterReference: String
        let minWithdrawEuro: String
        let symbolCharacter: String
        let hasWallets: Bool
        let logo: String
        let logoDark: String
        let logoWhite: String
        let logoColor: String
        let nameDeu: String
        let nameEng: String
        let nameFra: String

    }
}
