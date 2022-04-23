//
//  UIKit+Gradient.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import Foundation

import UIKit

extension UIView {
    public enum DirectionGradient {
        case horizontally
        case vertically
        case under45degreesLeftToRight
        case under45degreesRightToLeft

        // MARK: Internal

        var startPoint: CGPoint {
            switch self {
            case .horizontally,
                 .vertically,
                 .under45degreesLeftToRight:
                return CGPoint(x: 0.0, y: 0.0)
            case .under45degreesRightToLeft:
                return CGPoint(x: 1.0, y: 0.0)
            }
        }

        var endPoint: CGPoint {
            switch self {
            case .horizontally:
                return CGPoint(x: 1.0, y: 0.0)
            case .vertically:
                return CGPoint(x: 0.0, y: 1.0)
            case .under45degreesLeftToRight:
                return CGPoint(x: 1.0, y: 1.0)
            case .under45degreesRightToLeft:
                return CGPoint(x: 0.0, y: 1.0)
            }
        }
    }

    public func setGradient(
        colors: [UIColor],
        direction: DirectionGradient = .horizontally,
        locations: (Double, Double) = (0, 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = frame.size
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = [NSNumber(value: locations.0), NSNumber(value: locations.1)]
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }

    public func transactionAnimation(
        with duration: CFTimeInterval,
        timingFuncion: CAMediaTimingFunction,
        animations: () -> Void) {
        CATransaction.begin()
        CATransaction.disableActions()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(timingFuncion)
        animations()
        CATransaction.commit()
    }
}
