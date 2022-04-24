//
//  UIColor+Tools.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import UIKit

extension UIColor {

    public class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { (traits: UITraitCollection) -> UIColor in
            switch traits.userInterfaceStyle {
            case .dark:
                return dark
            case .light,
                 .unspecified:
                return light
            @unknown default:
                return light
            }
        }
    }
}
