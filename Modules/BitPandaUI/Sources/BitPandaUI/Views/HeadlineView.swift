//
//  HeadlineView.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import Foundation
import UIKit

// MARK: - HeadlineViewInput

public protocol HeadlineViewInput {
    var title: String? { get set }
    var caption: String? { get set }
}

// MARK: - HeadlineView

public final class HeadlineView: View {

    // MARK: Lifecycle

    override public init() {
        super.init()

        createUI()
        configureUI()
        layout()
    }

    // MARK: Public

    public var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    public var caption: String? {
        get {
            captionLabel.text
        }
        set {
            captionLabel.text = newValue
        }
    }

    // MARK: Internal

    private(set) var textContainer: UIStackView = .init()
    private(set) var titleLabel: UILabel = .init()
    private(set) var captionLabel: UILabel = .init()

    // MARK: Private

    private var activeConstraints: [NSLayoutConstraint] = []

    private func createUI() {
        addSubview(textContainer)

        textContainer.addArrangedSubview(titleLabel)
        textContainer.addArrangedSubview(captionLabel)
    }

    private func configureUI() {
        textContainer.axis = .vertical
        textContainer.distribution = .fill
        textContainer.spacing = 2

        titleLabel.font = UIFont.Body.Size14.medium
        titleLabel.textColor = Theme.Text.primary

        captionLabel.font = UIFont.Body.Size12.regular
        captionLabel.textColor = Theme.Text.secondary
    }

    private func layout() {
        textContainer.translatesAutoresizingMaskIntoConstraints = false

        activeConstraints = [
            textContainer.leading.constraint(equalTo: leading, constant: Spacing.x16),
            textContainer.trailing.constraint(equalTo: trailing, constant: Spacing.x16),
            textContainer.top.constraint(equalTo: top),
            textContainer.bottom.constraint(equalTo: bottom),
        ]

        NSLayoutConstraint.activate(activeConstraints)
    }
}

// MARK: HeadlineViewInput

extension HeadlineView: HeadlineViewInput { }
