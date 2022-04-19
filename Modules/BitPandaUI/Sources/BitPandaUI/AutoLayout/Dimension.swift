//
//  Dimension.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import UIKit.NSLayoutConstraint
import UIKit.UIView

public class Dimension: Anchor {

    public func constraint(equalTo anchor: Dimension, multiplier: CGFloat) -> NSLayoutConstraint {
        constraint(equalTo: anchor, multiplier: multiplier, constant: 0)
    }

    public func constraint(equalTo anchor: Dimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .equal,
            toItem: anchor.view,
            attribute: anchor.attribute,
            multiplier: multiplier,
            constant: constant)
    }

    public func constraint(equalToConstant constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant)
    }

    public func constraint(greaterThanOrEqualTo anchor: Dimension, multiplier: CGFloat) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: 0)
    }

    public func constraint(
        greaterThanOrEqualTo anchor: Dimension,
        multiplier: CGFloat,
        constant: CGFloat)
        -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .greaterThanOrEqual,
            toItem: anchor.view,
            attribute: anchor.attribute,
            multiplier: multiplier,
            constant: constant)
    }

    public func constraint(greaterThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant)
    }

    public func constraint(lessThanOrEqualTo anchor: Dimension, multiplier: CGFloat) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: 0)
    }

    public func constraint(
        lessThanOrEqualTo anchor: Dimension,
        multiplier: CGFloat,
        constant: CGFloat)
        -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .lessThanOrEqual,
            toItem: anchor.view,
            attribute: anchor.attribute,
            multiplier: multiplier,
            constant: constant)
    }

    public func constraint(lessThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .lessThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant)
    }
}
