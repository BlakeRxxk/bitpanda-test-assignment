//
//  WalletGroupsCell.swift
//  WalletsFeature
//

import BitPandaCore
import BitPandaUI
import UIKit

// MARK: - WalletGroupsCell

public final class WalletGroupsCell: UICollectionViewCell {

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

    override public var isHighlighted: Bool {
        didSet {
            updateHighlighted(isHighlighted)
        }
    }

    // MARK: Internal

    static let reuseIdentifier = "WalletRowCellID"

    private(set) var headline: HeadlineView = .init()
    private(set) var image: GradientIcon = .init()
    private(set) var arrow: UIImageView = .init()

    var model: WalletGroupCellModel? {
        didSet {
            guard oldValue != model else { return }
            updateCell(with: model)
        }
    }

    // MARK: Private

    private var activeConstraints: [NSLayoutConstraint] = []

    private func createUI() {
        contentView.addSubview(image)
        contentView.addSubview(headline)
        contentView.addSubview(arrow)
    }

    private func configureUI() {
        contentView.layer.cornerRadius = CornerRadius.x12
        contentView.layer.cornerCurve = .continuous

        arrow.image = UIImage.Arrow.left
        arrow.tintColor = Theme.Background.iconInactive
    }

    private func layout() {
        [headline, image, arrow].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        activeConstraints = [
            image.leading.constraint(equalTo: contentView.leading, constant: Spacing.x16),
            image.width.constraint(equalToConstant: Spacing.x40),
            image.height.constraint(equalToConstant: Spacing.x40),
            image.centerY.constraint(equalTo: contentView.centerY),

            headline.leading.constraint(equalTo: image.trailing),
            headline.centerY.constraint(equalTo: contentView.centerY),

            arrow.centerY.constraint(equalTo: contentView.centerY),
            arrow.trailing.constraint(equalTo: contentView.trailing, constant: -Spacing.x16),
        ]

        NSLayoutConstraint.activate(activeConstraints)
    }

    private func updateCell(with model: WalletGroupCellModel?) {
        guard let model = model else { return }
        headline.configure(with: .init(title: model.title, caption: model.caption))
        image.configure(with: .init(
            image: model.type.icon,
            imageTintColor: Theme.Background.constantWhite))
    }
}

// MARK: HighlightableCell

extension WalletGroupsCell: HighlightableCell { }

// MARK: WalletGroupsCell.CellType

extension WalletGroupsCell {
    public enum CellType: String {
        case commodity
        case cryptocoin
        case fiat

        var icon: UIImage {
            switch self {
            case .commodity:
                return UIImage.wallet
            case .cryptocoin:
                return UIImage.crypto
            case .fiat:
                return UIImage.fiat
            }
        }
    }
}
