//
//  File.swift
//
//
//  Created by Олег Кургаев on 21.04.2022.
//

import UIKit

extension UIImage {

    public static var wallet: UIImage {
        named("wallet").withRenderingMode(.alwaysTemplate)
    }

    public static var assets: UIImage {
        named("assets").withRenderingMode(.alwaysTemplate)
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
