//
//  CustomFont+Size.swift
//  BitPandaUI
//

import Foundation

extension CustomFont {
    enum Size {
        enum Display: CGFloat {
            case large = 56.0
            case medium = 40.0
            case small = 32.0
        }
        
        enum Heading: CGFloat {
            case h1 = 24.0
            case h2 = 18.0
            case h3 = 16.0
            case h4 = 14.0
        }
        
        enum Body: CGFloat {
            case subtitle = 18.0
            case large = 16.0
            case medium = 14.0
            case small = 12.0
            case caption = 10.0
        }
    }
}
