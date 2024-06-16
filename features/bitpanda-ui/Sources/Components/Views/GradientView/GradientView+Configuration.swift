//
//  GradientView+Configuration.swift
//  BitpandaUISDK
//

import UIKit

extension GradientView {
    public struct Configuration: Hashable {

        // MARK: Lifecycle

        public init(
            fromColor: UIColor,
            toColor: UIColor,
            direction: UIView.DirectionGradient,
            from: Double,
            to: Double) {
            self.fromColor = fromColor
            self.toColor = toColor
            self.direction = direction
            self.from = from
            self.to = to
        }

        public init(
            fromColor: UIColor,
            toColor: UIColor) {
            self.fromColor = fromColor
            self.toColor = toColor
            direction = .vertically
            from = 0
            to = 1
        }

        // MARK: Public

        public let fromColor: UIColor
        public let toColor: UIColor
        public let direction: UIView.DirectionGradient
        public let from: Double
        public let to: Double
    }
}
