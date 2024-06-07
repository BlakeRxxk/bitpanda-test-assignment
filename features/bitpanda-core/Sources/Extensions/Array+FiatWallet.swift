//
//  Array+FiatWallet.swift
//  BitPandaCore
//

import Foundation

extension Array where Element == FiatWallet {
    public func group(by keyPath: KeyPath<Element, String>) -> [(key: String, value: [Element])] {
        Dictionary(grouping: self, by: { $0[keyPath: keyPath] }).sorted(by: { $0.key < $1.key })
    }
}
