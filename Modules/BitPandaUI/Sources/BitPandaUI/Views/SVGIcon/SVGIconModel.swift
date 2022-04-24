//
//  File.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 24.04.2022.
//

import Foundation

extension SVGIcon {
    public struct Model {
        public let light: URL?
        public let dark: URL?

        public init(light: URL?, dark: URL?) {
            self.light = light
            self.dark = dark
        }
    }
}
