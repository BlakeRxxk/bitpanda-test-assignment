//
//  String+Localize.swift
//  BitPandaCore
//

import Foundation

extension String {
    public func localize(tableName: String? = nil, bundle: Bundle = .main, comment: String = "") -> String {
        NSLocalizedString(
            self,
            tableName: tableName,
            bundle: bundle,
            value: "",
            comment: comment)
    }
}
