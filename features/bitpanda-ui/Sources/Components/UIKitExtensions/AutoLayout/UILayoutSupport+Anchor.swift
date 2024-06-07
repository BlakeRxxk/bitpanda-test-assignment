//
//  UILayoutSupport+Anchor.swift
//  BitPandaUI
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
