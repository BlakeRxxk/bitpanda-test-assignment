//
//  UIImage+Images.swift
//  BitPandaUI
//

import UIKit

extension UIImage {

    public enum Arrow {
        public static var left: UIImage {
            named("arrow.left").withRenderingMode(.alwaysTemplate)
        }
    }

    public static var wallet: UIImage {
        named("wallet").withRenderingMode(.alwaysTemplate)
    }

    public static var assets: UIImage {
        named("assets").withRenderingMode(.alwaysTemplate)
    }

    public static var crypto: UIImage {
        named("crypto").withRenderingMode(.alwaysTemplate)
    }

    public static var fiat: UIImage {
        named("fiat").withRenderingMode(.alwaysTemplate)
    }
}

extension UIImage {
    // resource loader
    static func named(_ name: String) -> UIImage {
        guard let image = UIImage(named: name, in: Bundle.main, compatibleWith: nil) else {
            assertionFailure("Image '\(name)' not found")
            return UIImage()
        }
        return image
    }
}
