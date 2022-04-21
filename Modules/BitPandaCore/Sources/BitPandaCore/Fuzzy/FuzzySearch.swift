//
//  FuzzySearch.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 21.04.2022.
//

import Foundation

public enum Fuzzy {
    public static func search(needle: String, haystack: String) -> Bool {
        let needle = needle.lowercased()
        let haystack = haystack.lowercased()

        guard needle.count <= haystack.count else {
            return false
        }

        if needle == haystack {
            return true
        }

        var needleIdx = needle.startIndex
        var haystackIdx = haystack.startIndex

        while needleIdx != needle.endIndex {
            if haystackIdx == haystack.endIndex {
                return false
            }
            if needle[needleIdx] == haystack[haystackIdx] {
                needleIdx = needle.index(after: needleIdx)
            }
            haystackIdx = haystack.index(after: haystackIdx)
        }

        return true
    }
}
