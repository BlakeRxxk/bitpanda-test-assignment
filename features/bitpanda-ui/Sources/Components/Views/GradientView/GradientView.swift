//
//  GradientView.swift
//  BitPandaUI
//

import Foundation
import UIKit

public final class GradientView: View, ConfigurableView {

    // MARK: Public

    override public func layoutSubviews() {
        super.layoutSubviews()

        updateGradient()
    }

    public func configure(with configuration: Configuration) {
        fromColor = configuration.fromColor
        toColor = configuration.toColor
        direction = configuration.direction
        from = configuration.from
        to = configuration.to
        setNeedsLayout()
    }

    // MARK: Private

    private var fromColor: UIColor = .init()
    private var toColor: UIColor = .init()
    private var direction: UIView.DirectionGradient = .vertically
    private var from: Double = 0
    private var to: Double = 1

    private var hasGradient = false

    private func updateGradient() {
        guard frame.size.width != .zero && frame.size.height != .zero && !hasGradient else { return }
        hasGradient = true

        setGradient(colors: [fromColor, toColor], direction: direction, locations: (from, to))
    }

}
