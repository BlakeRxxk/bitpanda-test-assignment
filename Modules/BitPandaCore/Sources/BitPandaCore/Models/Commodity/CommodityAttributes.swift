//
//  CommodityAttributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Commodity {
    public struct Attributes: Codable {

        // MARK: Public

        public let symbol: String
        public let name: String
        public let sort: Int
        public let assetTypeName: Commodity.AssetType
        public let assetGroupName: Commodity.AssetGroup
        public let urlCheckAddress: String
        public let urlCheckTransaction: String
        public let buyActive: Bool
        public let sellActive: Bool
        public let withdrawActive: Bool
        public let depositActive: Bool
        public let transferActive: Bool
        public let available: Bool
        public let maintenanceEnabled: Bool
        public let minBuyEur: String
        public let minSellEur: String
        public let minWithdrawEur: String
        public let defaultSellAmount: String
        public let precisionForFiatPrice: Int
        public let precisionForCoins: Int
        public let precisionForTx: Int
        public let walletMinDeposit: String
        public let walletSmallDeposit: String
        public let walletSmallDepositFee: String
        public let avgPrice: String
        public let color: String
        public let walletWithdrawFee: String
        public let change24H: String
        public let change24HAmount: String
        public let change1W: String
        public let change1WAmount: String
        public let change1M: String
        public let change1MAmount: String
        public let change1Y: String
        public let change1YAmount: String
        public let logo: String
        public let logoDark: String
        public let supportDestinationTag: Bool
        public let circulatingSupply: String?
        public let allowedUnverified: Bool
        public let allowedDocumented: Bool
        public let allowedVerified: Bool
        public let measurementUnit: String?
        public let ieoPhases: [IeoPhase?]
        public let info: String
        public let unavailableReason: String
        public let maintenanceReason: String
        public let walletInfo: String
        public let extraInfo: String
        public let infoIntegration: String
        public let infoDeu: String
        public let infoEng: String
        public let infoFra: String
        public let unavailableReasonDeu: String
        public let unavailableReasonEng: String
        public let unavailableReasonFra: String
        public let maintenanceReasonDeu: String
        public let maintenanceReasonEng: String
        public let maintenanceReasonFra: String
        public let walletInfoDeu: String
        public let walletInfoEng: String
        public let walletInfoFra: String
        public let extraInfoDeu: String
        public let extraInfoEng: String
        public let extraInfoFra: String
        public let infoIntegrationDeu: String
        public let infoIntegrationEng: String
        public let infoIntegrationFra: String
        public let investmentInfo: String?
        public let investmentInfoDeu: String?
        public let investmentInfoEng: String?
        public let investmentInfoFra: String?
        public let androidSupportedVersion: String?
        public let iosSupportedVersion: String?
        public let family: Commodity.Attributes.Family?

        // MARK: Internal

        enum CodingKeys: String, CodingKey {
            case symbol
            case name
            case sort
            case assetTypeName = "asset_type_name"
            case assetGroupName = "asset_group_name"
            case urlCheckAddress = "url_check_address"
            case urlCheckTransaction = "url_check_transaction"
            case buyActive = "buy_active"
            case sellActive = "sell_active"
            case withdrawActive = "withdraw_active"
            case depositActive = "deposit_active"
            case transferActive = "transfer_active"
            case available
            case maintenanceEnabled = "maintenance_enabled"
            case minBuyEur = "min_buy_eur"
            case minSellEur = "min_sell_eur"
            case minWithdrawEur = "min_withdraw_eur"
            case defaultSellAmount = "default_sell_amount"
            case precisionForFiatPrice = "precision_for_fiat_price"
            case precisionForCoins = "precision_for_coins"
            case precisionForTx = "precision_for_tx"
            case walletMinDeposit = "wallet_min_deposit"
            case walletSmallDeposit = "wallet_small_deposit"
            case walletSmallDepositFee = "wallet_small_deposit_fee"
            case avgPrice = "avg_price"
            case color
            case walletWithdrawFee = "wallet_withdraw_fee"
            case change24H = "change_24h"
            case change24HAmount = "change_24h_amount"
            case change1W = "change_1w"
            case change1WAmount = "change_1w_amount"
            case change1M = "change_1m"
            case change1MAmount = "change_1m_amount"
            case change1Y = "change_1y"
            case change1YAmount = "change_1y_amount"
            case logo
            case logoDark = "logo_dark"
            case supportDestinationTag = "support_destination_tag"
            case circulatingSupply = "circulating_supply"
            case allowedUnverified = "allowed_unverified"
            case allowedDocumented = "allowed_documented"
            case allowedVerified = "allowed_verified"
            case measurementUnit = "measurement_unit"
            case ieoPhases = "ieo_phases"
            case info
            case unavailableReason = "unavailable_reason"
            case maintenanceReason = "maintenance_reason"
            case walletInfo = "wallet_info"
            case extraInfo = "extra_info"
            case infoIntegration = "info_integration"
            case infoDeu = "info_deu"
            case infoEng = "info_eng"
            case infoFra = "info_fra"
            case unavailableReasonDeu = "unavailable_reason_deu"
            case unavailableReasonEng = "unavailable_reason_eng"
            case unavailableReasonFra = "unavailable_reason_fra"
            case maintenanceReasonDeu = "maintenance_reason_deu"
            case maintenanceReasonEng = "maintenance_reason_eng"
            case maintenanceReasonFra = "maintenance_reason_fra"
            case walletInfoDeu = "wallet_info_deu"
            case walletInfoEng = "wallet_info_eng"
            case walletInfoFra = "wallet_info_fra"
            case extraInfoDeu = "extra_info_deu"
            case extraInfoEng = "extra_info_eng"
            case extraInfoFra = "extra_info_fra"
            case infoIntegrationDeu = "info_integration_deu"
            case infoIntegrationEng = "info_integration_eng"
            case infoIntegrationFra = "info_integration_fra"
            case investmentInfo = "investment_info"
            case investmentInfoDeu = "investment_info_deu"
            case investmentInfoEng = "investment_info_eng"
            case investmentInfoFra = "investment_info_fra"
            case androidSupportedVersion = "android_supported_version"
            case iosSupportedVersion = "ios_supported_version"
            case family
        }

    }
}
