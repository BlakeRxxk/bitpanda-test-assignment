//
//  UILayoutPriority+Constants.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import struct UIKit.UILayoutPriority

extension UILayoutPriority {
    public static let highest = UILayoutPriority.required - 1
}

extension UILayoutPriority {
    public static func + (left: UILayoutPriority, right: Float) -> UILayoutPriority {
        UILayoutPriority(rawValue: left.rawValue + right)
    }

    public static func - (left: UILayoutPriority, right: Float) -> UILayoutPriority {
        UILayoutPriority(rawValue: left.rawValue - right)
    }
}
