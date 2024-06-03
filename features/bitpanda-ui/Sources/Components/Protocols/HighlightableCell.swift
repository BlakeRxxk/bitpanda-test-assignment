//
//  HighlightableCell.swift
//  BitPandaUI
//

import UIKit

// MARK: - HighlightableCell

public protocol HighlightableCell: UICollectionViewCell {
    func updateHighlighted(_ isHighlighted: Bool)
}

extension HighlightableCell {
    public func updateHighlighted(_ isHighlighted: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.contentView.backgroundColor = isHighlighted
                ? Theme.Background.highlighted
                : .clear
        }
    }
}
