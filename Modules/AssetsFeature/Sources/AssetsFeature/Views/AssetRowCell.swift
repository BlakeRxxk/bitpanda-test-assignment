//
//  AssetRowCell.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import BitPandaUI
import UIKit

// MARK: - AssetRowCell

class AssetRowCell: UICollectionViewCell {

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

    private(set) var textContainer: UIStackView = .init()
    private(set) var title: UILabel = .init()
    private(set) var caption: UILabel = .init()
    private(set) var amount: UILabel = .init()
    private(set) var image: Icon = .init()

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
        image.update(with: Icon.Model(light: lightLogo, dark: darkLogo))
    }

    // MARK: Private

    private var lightLogo: URL?
    private var darkLogo: URL?

    private var activeConstraints: [NSLayoutConstraint] = []

    private func createUI() {
        contentView.addSubview(image)
        contentView.addSubview(textContainer)
        contentView.addSubview(amount)

        textContainer.addArrangedSubview(title)
        textContainer.addArrangedSubview(caption)
    }

    private func configureUI() {
        textContainer.axis = .vertical
        textContainer.distribution = .fill
        textContainer.spacing = 2

        title.font = UIFont.Body.Size14.medium
        title.textColor = Theme.Text.primary

        caption.font = UIFont.Body.Size12.regular
        caption.textColor = Theme.Text.secondary

        amount.font = UIFont.Body.Size16.medium
        amount.textColor = Theme.Text.primary
        contentView.layer.cornerRadius = CornerRadius.x12
    }

    private func layout() {
        [textContainer, image, amount].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        activeConstraints = [
            image.leading.constraint(equalTo: contentView.leading, constant: Spacing.x16),
            image.width.constraint(equalToConstant: Spacing.x40),
            image.height.constraint(equalToConstant: Spacing.x40),
            image.centerY.constraint(equalTo: contentView.centerY),

            textContainer.leading.constraint(equalTo: image.trailing, constant: Spacing.x16),
            textContainer.centerY.constraint(equalTo: contentView.centerY),
            textContainer.trailing.constraint(equalTo: amount.trailing),

            amount.centerY.constraint(equalTo: contentView.centerY),
            amount.trailing.constraint(equalTo: contentView.trailing, constant: -Spacing.x16),
        ]

        NSLayoutConstraint.activate(activeConstraints)
    }

    private func updateCell(with model: AssetCellModel?) {
        guard let model = model else { return }

        title.text = model.title
        caption.text = model.caption
        darkLogo = model.darkLogo
        lightLogo = model.lightLogo
        amount.text = model.amount
        loadImage()
    }

    private func updateHighlighted(_ isHighlighted: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.contentView.backgroundColor = isHighlighted
                ? Theme.Background.highlighted
                : .clear
        }
    }
}
