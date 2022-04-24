//
//  String+Localize.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 24.04.2022.
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
