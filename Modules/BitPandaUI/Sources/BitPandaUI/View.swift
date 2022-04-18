//
//  View.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import UIKit

open class View: UIView {
    public init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable, message: "NSCoder and Interface Builder is not supported. Use Programmatic layout.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
