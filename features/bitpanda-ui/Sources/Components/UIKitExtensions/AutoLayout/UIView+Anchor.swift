//
//  UIView+Anchor.swift
//  BitPandaUI
//

import UIKit.UIView

extension UIView {
    public var left: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .left)
    }

    public var right: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .right)
    }

    public var top: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .top)
    }

    public var bottom: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .bottom)
    }

    public var leading: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .leading)
    }

    public var trailing: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .trailing)
    }

    public var width: Dimension {
        Dimension(view: self, attribute: .width)
    }

    public var height: Dimension {
        Dimension(view: self, attribute: .height)
    }

    public var centerX: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .centerX)
    }

    public var centerY: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .centerY)
    }

    public var lastBaseline: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .lastBaseline)
    }

    public var firstBaseline: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .firstBaseline)
    }

    public var leftMargin: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .leftMargin)
    }

    public var rightMargin: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .rightMargin)
    }

    public var topMargin: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .topMargin)
    }

    public var bottomMargin: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .bottomMargin)
    }

    public var leadingMargin: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .leadingMargin)
    }

    public var trailingMargin: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .trailingMargin)
    }

    public var centerXWithinMargins: XAxisAnchor {
        XAxisAnchor(view: self, attribute: .centerXWithinMargins)
    }

    public var centerYWithinMargins: YAxisAnchor {
        YAxisAnchor(view: self, attribute: .centerYWithinMargins)
    }
}
