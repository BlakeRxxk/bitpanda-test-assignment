//
//  FiatAttributes.swift
//  BitPandaCore
//

import Foundation

extension Fiat {
    public struct Attributes: Codable {

        // MARK: Public

        public let symbol: String
        public let name: String
        public let precision: Int
        public let toEurRate: String
        public let defaultSellAmount: String
        public let numericCharacterReference: String
        public let minWithdrawEuro: String
        public let symbolCharacter: String
        public let hasWallets: Bool
        public let logo: String
        public let logoDark: String
        public let logoWhite: String
        public let logoColor: String
        public let nameDeu: String
        public let nameEng: String
        public let nameFra: String

        // MARK: Internal

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

    }
}
