//
//  NumberFactory.swift
//  BitPandaCore
//

import Foundation

public enum NumberFactory {
    public static func rawToMoneyString(value: String?, precision: Int, currencyCode: String = "EUR") -> String {
        let formatter = NumberFormatter()

        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.allowsFloats = true
        formatter.maximumFractionDigits = precision
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = currencyCode

        guard
            let price = Double(value ?? ""),
            let result = formatter.string(from: NSNumber(value: price))
        else {
            return ""
        }

        return result
    }
}
