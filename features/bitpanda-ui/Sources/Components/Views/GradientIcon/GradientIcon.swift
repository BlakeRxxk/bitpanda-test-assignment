//
//  GradientIcon.swift
//  BitPandaUI
//

import Foundation
import UIKit

// MARK: - GradientIcon

public final class GradientIcon: View, ConfigurableView {

    // MARK: Lifecycle

    public override init() {
        super.init()

        createUI()
        configureUI()
    }

    // MARK: Public

    public override var intrinsicContentSize: CGSize {
        sizeThatFits(CGSize(width: CGFloat.infinity, height: 0))
    }

    public func configure(with configuration: Configuration) {
        imageView.image = configuration.image
        imageView.tintColor = configuration.imageTintColor
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }

    public override func sizeThatFits(_: CGSize) -> CGSize {
        CGSize(width: Spacing.x40, height: Spacing.x40)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let gradientViewFrame = CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: Spacing.x40,
            height: Spacing.x40)

        let imageViewFrame = CGRect(
            x: (Spacing.x40 - Spacing.x24) / 2,
            y: (Spacing.x40 - Spacing.x24) / 2,
            width: Spacing.x24,
            height: Spacing.x24)

        imageView.frame = imageViewFrame
        gradientView.frame = gradientViewFrame
    }

    // MARK: Internal

    private(set) var imageView: UIImageView = .init(frame: .zero)
    private(set) var gradientView: GradientView = .init()

    // MARK: Private

    private func createUI() {
        addSubview(gradientView)
        addSubview(imageView)
    }

    private func configureUI() {
        layer.cornerRadius = CornerRadius.x8
        layer.cornerCurve = .continuous
        clipsToBounds = true
        gradientView.configure(with: .init(
            fromColor: Theme.GradientPrimary.from,
            toColor: Theme.GradientPrimary.to))
    }
}
