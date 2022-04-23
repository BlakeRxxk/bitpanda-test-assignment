//
//  BaseListView.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import Foundation
import UIKit

open class BaseListView: View {

    // MARK: Lifecycle

    override public init() {
        super.init()

        createUI()
        configureUI()
    }

    // MARK: Open

    open func createUI() {
        collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: .defaultLayout())

        guard let collectionView = collectionView else { return }
        addSubview(collectionView)
    }

    open func configureUI() {
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = Theme.Background.primary
    }

    // MARK: Public

    public private(set) var collectionView: UICollectionView?

}
