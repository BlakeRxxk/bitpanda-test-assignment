//
//  Anchor.swift
//  BitPandaUI
//

import UIKit.NSLayoutConstraint
import UIKit.UIView

// MARK: - XAxisAnchor

public class XAxisAnchor: Anchor {}

// MARK: - YAxisAnchor

public class YAxisAnchor: Anchor {}

// MARK: - Anchor

public class Anchor {

    // MARK: Lifecycle

    internal init(view: Any, attribute: NSLayoutConstraint.Attribute) {
        self.view = view
        self.attribute = attribute
    }

    // MARK: Public

    public func constraint(equalTo anchor: Anchor) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: 0)
    }

    public func constraint(equalTo anchor: Anchor, constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .equal,
            toItem: anchor.view,
            attribute: anchor.attribute,
            multiplier: 1,
            constant: constant)
    }

    public func constraint(greaterThanOrEqualTo anchor: Anchor) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: 0)
    }

    public func constraint(greaterThanOrEqualTo anchor: Anchor, constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .greaterThanOrEqual,
            toItem: anchor.view,
            attribute: anchor.attribute,
            multiplier: 1,
            constant: constant)
    }

    public func constraint(lessThanOrEqualTo anchor: Anchor) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: 0)
    }

    public func constraint(lessThanOrEqualTo anchor: Anchor, constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .lessThanOrEqual,
            toItem: anchor.view,
            attribute: anchor.attribute,
            multiplier: 1,
            constant: constant)
    }

    // MARK: Internal

    internal let view: Any
    internal let attribute: NSLayoutConstraint.Attribute
}
