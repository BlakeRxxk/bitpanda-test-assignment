//
//  AssetRowCell.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import BitPandaUI
import UIKit

// MARK: - AssetRowCell

final class AssetRowCell: UICollectionViewCell {

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

    static let reuseIdentifier = "AssetRowCellID"

    private(set) var headline: HeadlineView = .init()
    private(set) var amount: UILabel = .init()
    private(set) var image: SVGIcon = .init()

    var model: AssetCellModel? {
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

    override func prepareForReuse() {
        super.prepareForReuse()
        image.prepareForReuse()
    }

    func loadImage() {
        image.update(with: SVGIcon.Model(light: lightLogo, dark: darkLogo))
    }

    // MARK: Private

    private var lightLogo: URL?
    private var darkLogo: URL?

    private var activeConstraints: [NSLayoutConstraint] = []

    private func createUI() {
        contentView.addSubview(image)
        contentView.addSubview(headline)
        contentView.addSubview(amount)
    }

    private func configureUI() {
        amount.font = UIFont.Body.Size16.medium
        amount.textColor = Theme.Text.primary
        contentView.layer.cornerRadius = CornerRadius.x12
        contentView.layer.cornerCurve = .continuous
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

    private func updateCell(with model: AssetCellModel?) {
        guard let model = model else { return }

        headline.title = model.title
        headline.caption = model.caption
        darkLogo = model.darkLogo
        lightLogo = model.lightLogo
        amount.text = model.amount
    }
}

// MARK: HighlightableCell

extension AssetRowCell: HighlightableCell { }
