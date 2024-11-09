//
//  HeadlineView.swift
//  BitPandaUI
//

import Foundation
import UIKit

// MARK: - HeadlineViewInput

public protocol HeadlineViewInput {
    var title: String? { get set }
    var caption: String? { get set }
}

// MARK: - HeadlineView

public final class HeadlineView: View, ConfigurableView {

    // MARK: Lifecycle

    override public init() {
        super.init()

        createUI()
        configureUI()
        layout()
    }

    // MARK: Public

    public override var intrinsicContentSize: CGSize {
        sizeThatFits(CGSize(width: CGFloat.infinity, height: 0))
    }

    public func configure(with configuration: Configuration) {
        titleLabel.text = configuration.title
        captionLabel.text = configuration.caption
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }

    public override func sizeThatFits(_: CGSize) -> CGSize {
        CGSize(width: Spacing.x40, height: Spacing.x40)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
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

extension HeadlineView {
    public struct Configuration: Hashable {
        public let title: String
        public let caption: String?

        public init(title: String, caption: String?) {
            self.title = title
            self.caption = caption
        }
    }
}
