//
//  CALayer+Border.swift
//  BitPandaUI
//

import Foundation
import UIKit

extension CALayer {

    public func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case .left:
            border.frame = CGRect(x: 0, y: frame.height / 4, width: thickness, height: frame.height / 2)
            break
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: frame.height / 4, width: thickness, height: frame.height / 2)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        addSublayer(border)
    }
}
