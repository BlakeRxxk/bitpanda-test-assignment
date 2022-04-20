//
//  Attributes.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

extension Commodity {
    struct Attributes: Codable {
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

        let symbol: String
        let name: String
        let sort: Int
        let assetTypeName: Commodity.AssetType
        let assetGroupName: Commodity.AssetGroup
        let urlCheckAddress: String
        let urlCheckTransaction: String
        let buyActive: Bool
        let sellActive: Bool
        let withdrawActive: Bool
        let depositActive: Bool
        let transferActive: Bool
        let available: Bool
        let maintenanceEnabled: Bool
        let minBuyEur: String
        let minSellEur: String
        let minWithdrawEur: String
        let defaultSellAmount: String
        let precisionForFiatPrice: Int
        let precisionForCoins: Int
        let precisionForTx: Int
        let walletMinDeposit: String
        let walletSmallDeposit: String
        let walletSmallDepositFee: String
        let avgPrice: String
        let color: String
        let walletWithdrawFee: String
        let change24H: String
        let change24HAmount: String
        let change1W: String
        let change1WAmount: String
        let change1M: String
        let change1MAmount: String
        let change1Y: String
        let change1YAmount: String
        let logo: String
        let logoDark: String
        let supportDestinationTag: Bool
        let circulatingSupply: String?
        let allowedUnverified: Bool
        let allowedDocumented: Bool
        let allowedVerified: Bool
        let measurementUnit: String?
        let ieoPhases: [IeoPhase]
        let info: String
        let unavailableReason: String
        let maintenanceReason: String
        let walletInfo: String
        let extraInfo: String
        let infoIntegration: String
        let infoDeu: String
        let infoEng: String
        let infoFra: String
        let unavailableReasonDeu: String
        let unavailableReasonEng: String
        let unavailableReasonFra: String
        let maintenanceReasonDeu: String
        let maintenanceReasonEng: String
        let maintenanceReasonFra: String
        let walletInfoDeu: String
        let walletInfoEng: String
        let walletInfoFra: String
        let extraInfoDeu: String
        let extraInfoEng: String
        let extraInfoFra: String
        let infoIntegrationDeu: String
        let infoIntegrationEng: String
        let infoIntegrationFra: String
        let investmentInfo: String?
        let investmentInfoDeu: String?
        let investmentInfoEng: String?
        let investmentInfoFra: String?
        let androidSupportedVersion: String?
        let iosSupportedVersion: String?
        let family: Commodity.Attributes.Family?

    }
}
