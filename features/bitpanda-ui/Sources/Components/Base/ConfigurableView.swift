//
//  ConfigurableView.swift
//  BitPandaUI
//

import Foundation
import UIKit

public protocol ConfigurableView: UIView {
    associatedtype Configuration: Hashable

    func configure(with configuration: Configuration)
}
