//
//  AssetRowCell.swift
//  BitPanda
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

    // MARK: Public

    override public func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        caption.text = nil
        amount.text = nil
        image.image = nil
    }

    // MARK: Internal

    static let reuseIdentifier = "AssetRowCellID"

    private(set) var textContainer: UIStackView = .init()
    private(set) var title: UILabel = .init()
    private(set) var caption: UILabel = .init()
    private(set) var amount: UILabel = .init()
    private(set) var image: UIImageView = .init()

    var model: Asset? {
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
        title.textColor = UIColor.gray100

        caption.font = UIFont.Body.Size12.regular
        caption.textColor = UIColor.gray60

        amount.font = UIFont.Body.Size16.medium
        amount.textColor = UIColor.gray100
        contentView.layer.cornerRadius = Constants.cornerRadius
    }

    private func layout() {
        [textContainer, image, amount].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        activeConstraints = [
            image.leading.constraint(equalTo: contentView.leading, constant: Constants.offset),
            image.width.constraint(equalToConstant: Constants.imageSize),
            image.height.constraint(equalToConstant: Constants.imageSize),
            image.centerY.constraint(equalTo: contentView.centerY),

            textContainer.leading.constraint(equalTo: image.trailing, constant: Constants.offset),
            textContainer.centerY.constraint(equalTo: contentView.centerY),
            textContainer.trailing.constraint(equalTo: amount.trailing),

            amount.centerY.constraint(equalTo: contentView.centerY),
            amount.trailing.constraint(equalTo: contentView.trailing, constant: -Constants.offset)
        ]

        NSLayoutConstraint.activate(activeConstraints)
    }

    private func updateCell(with model: Asset?) {
        guard let model = model else { return }

        title.text = model.title
        caption.text = model.caption
        amount.text = String(format: "+$ %.3f", model.amount)
        image.image = model.image
    }

    private func updateHighlighted(_ isHighlighted: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.contentView.backgroundColor = isHighlighted ? .gray16 : .clear
        }
    }
}

extension AssetRowCell {
    fileprivate enum Constants {
        static let imageSize: CGFloat = 40
        static let offset: CGFloat = 16
        static let cornerRadius: CGFloat = 12
    }
}
