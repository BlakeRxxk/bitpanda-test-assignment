//
//  CustomFont.swift
//  BitPandaUI
//

import Foundation

// MARK: - CustomFont

enum CustomFont: String {
    case dmSans = "DMSans"
}

// MARK: CustomFont.Style

extension CustomFont {
    enum Style: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case regular = "-Regular"
        case semiBold = "-SemiBold"
    }
}
