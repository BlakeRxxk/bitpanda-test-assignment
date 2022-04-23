//
//  HighlightableCell.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 23.04.2022.
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
