//
//  Theme.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation
import UIKit

public enum Theme {

    public enum Text {
        @nonobjc public static var primary: UIColor = .dynamicColor(
            light: UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1))

        @nonobjc public static var accent: UIColor = .dynamicColor(
            light: UIColor(red: 0.675, green: 0.676, blue: 0.69, alpha: 0.8),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 0.64))

        public static let secondary: UIColor = .dynamicColor(
            light: UIColor(red: 0.675, green: 0.676, blue: 0.69, alpha: 0.8),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 0.64))

        public static let success: UIColor = .dynamicColor(
            light: UIColor(red: 0.145, green: 0.761, blue: 0.431, alpha: 1),
            dark: UIColor(red: 0.183, green: 0.867, blue: 0.497, alpha: 1))

        public static let navigation: UIColor = .dynamicColor(
            light: UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1))
    }

    public enum Background {
        public static let primary: UIColor = .dynamicColor(
            light: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1),
            dark: UIColor(red: 0.102, green: 0.106, blue: 0.153, alpha: 1))

        public static let highlighted: UIColor = .dynamicColor(
            light: UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 0.04))

        public static let icon: UIColor = .dynamicColor(
            light: UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1))

        public static let tabBar: UIColor = .dynamicColor(
            light: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 0.64),
            dark: UIColor(red: 0.102, green: 0.106, blue: 0.153, alpha: 0.8))

        public static let iconInactive: UIColor = .dynamicColor(
            light: UIColor(red: 0.675, green: 0.676, blue: 0.69, alpha: 0.8),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 0.4))

        public static let constantWhite: UIColor = .dynamicColor(
            light: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1),
            dark: UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1))
    }

    public enum GradientPrimary {
        public static let from: UIColor = .dynamicColor(
            light: UIColor(red: 0.329, green: 0.477, blue: 1, alpha: 1),
            dark: UIColor(red: 0.329, green: 0.477, blue: 1, alpha: 1))

        public static let to: UIColor = .dynamicColor(
            light: UIColor(red: 0.254, green: 0.239, blue: 1, alpha: 1),
            dark: UIColor(red: 0.254, green: 0.239, blue: 1, alpha: 1))

    }

    public enum GradientSecondary {
        public static let from: UIColor = .dynamicColor(
            light: UIColor(red: 1, green: 0.49, blue: 0.329, alpha: 1),
            dark: UIColor(red: 1, green: 0.49, blue: 0.329, alpha: 1))

        public static let to: UIColor = .dynamicColor(
            light: UIColor(red: 1, green: 0.239, blue: 0.239, alpha: 1),
            dark: UIColor(red: 1, green: 0.239, blue: 0.239, alpha: 1))

    }

    public enum GradientAccent {
        public static let from: UIColor = .dynamicColor(
            light: UIColor(red: 0.29, green: 1, blue: 0.529, alpha: 1),
            dark: UIColor(red: 0.29, green: 1, blue: 0.529, alpha: 1))

        public static let to: UIColor = .dynamicColor(
            light: UIColor(red: 0.051, green: 0.161, blue: 0.90, alpha: 1),
            dark: UIColor(red: 0.110, green: 0.257, blue: 0.196, alpha: 1))

    }

}
