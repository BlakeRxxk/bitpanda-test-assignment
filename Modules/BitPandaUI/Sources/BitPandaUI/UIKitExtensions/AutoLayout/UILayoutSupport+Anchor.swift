//
//  UILayoutSupport+Anchor.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import UIKit.NSLayoutConstraint

extension UILayoutSupport {
    public var top: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .top)
    }

    public var bottom: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .bottom)
    }

    public var height: Dimension {
        Dimension(view: self, attribute: .height)
    }
}
