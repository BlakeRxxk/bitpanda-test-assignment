//
//  GradientIcon.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import Foundation
import PINCache
import SVGKit
import SVGKitSwift

// MARK: - GradientIcon

public final class GradientIcon: View {

    // MARK: Lifecycle

    public override init() {
        super.init()

        createUI()
        configureUI()
        layout()
    }

    // MARK: Public

    public var icon: UIImage? {
        get {
            imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    public var imageTintColor: UIColor = Theme.Background.constantWhite {
        didSet {
            updateView()
        }
    }

    // MARK: Internal

    private(set) var imageView: UIImageView = .init(frame: .zero)
    private(set) var gradientView: GradientView = .init()

    // MARK: Private

    private var activeConstraints: [NSLayoutConstraint] = []

    private func createUI() {
        addSubview(gradientView)
        addSubview(imageView)
    }

    private func configureUI() {
        layer.cornerRadius = CornerRadius.x8
        layer.cornerCurve = .continuous
        clipsToBounds = true
        gradientView.fromColor = Theme.GradientPrimary.from
        gradientView.toColor = Theme.GradientPrimary.to
        updateView()
    }

    private func layout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false

        activeConstraints = [
            imageView.width.constraint(equalToConstant: Spacing.x24),
            imageView.height.constraint(equalToConstant: Spacing.x24),
            imageView.centerX.constraint(equalTo: centerX),
            imageView.centerY.constraint(equalTo: centerY),
            gradientView.width.constraint(equalToConstant: Spacing.x40),
            gradientView.height.constraint(equalToConstant: Spacing.x40),
        ]

        NSLayoutConstraint.activate(activeConstraints)
    }

    private func updateView() {
        imageView.tintColor = imageTintColor
    }
}
