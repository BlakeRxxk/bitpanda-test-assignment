//
//  GradientView.swift
//  BitPandaUI
//

import Foundation
import UIKit

public final class GradientView: View {

    // MARK: Public

    public var fromColor: UIColor = .init()
    public var toColor: UIColor = .init()
    public var direction: UIView.DirectionGradient = .vertically
    public var from: Double = 0
    public var to: Double = 1

    override public func layoutSubviews() {
        super.layoutSubviews()

        updateGradient()
    }

    // MARK: Private

    private var hasGradient = false

    private func updateGradient() {
        guard frame.size.width != .zero && frame.size.height != .zero && !hasGradient else { return }
        hasGradient = true

        setGradient(colors: [fromColor, toColor], direction: direction, locations: (from, to))
    }

}
