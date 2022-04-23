//
//  WalletDetailRowCell.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import BitPandaUI
import UIKit

// MARK: - WalletDetailRowCell

class WalletDetailRowCell: UICollectionViewCell {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
        configureUI()
        layout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    static let reuseIdentifier = "WalletDetailRowCellID"

    private(set) var headline: HeadlineView = .init()
    private(set) var image: GradientIcon = .init()
    private(set) var amount: UILabel = .init()

    var model: WalletDetailRowCellModel? {
        didSet {
            guard oldValue != model else { return }
            updateCell(with: model)
        }
    }

    override var isHighlighted: Bool {
        didSet {
            updateHighlighted(isHighlighted)
        }
    }

    // MARK: Private

    private var activeConstraints: [NSLayoutConstraint] = []

    private func createUI() {
        contentView.addSubview(image)
        contentView.addSubview(headline)
        contentView.addSubview(amount)
    }

    private func configureUI() {
        contentView.layer.cornerRadius = CornerRadius.x12
        amount.font = UIFont.Body.Size16.medium
        amount.textColor = Theme.Text.primary
        image.icon = UIImage.wallet
    }

    private func layout() {
        [headline, image, amount].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        activeConstraints = [
            image.leading.constraint(equalTo: contentView.leading, constant: Spacing.x16),
            image.width.constraint(equalToConstant: Spacing.x40),
            image.height.constraint(equalToConstant: Spacing.x40),
            image.centerY.constraint(equalTo: contentView.centerY),

            headline.leading.constraint(equalTo: image.trailing),
            headline.centerY.constraint(equalTo: contentView.centerY),
            headline.trailing.constraint(equalTo: amount.trailing),

            amount.centerY.constraint(equalTo: contentView.centerY),
            amount.trailing.constraint(equalTo: contentView.trailing, constant: -Spacing.x16),

        ]

        NSLayoutConstraint.activate(activeConstraints)
    }

    private func updateCell(with model: WalletDetailRowCellModel?) {
        guard let model = model else { return }
        headline.title = model.title
        headline.caption = model.caption
        amount.text = model.amount
    }

}

// MARK: HighlightableCell

extension WalletDetailRowCell: HighlightableCell {}
