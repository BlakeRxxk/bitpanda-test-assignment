//
//  AssetsView.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import BitPandaUI
import UIKit

public class AssetView: BaseListView {

    // MARK: Public

    override public func createUI() {
        super.createUI()

        collectionView?.register(
            AssetRowCell.self,
            forCellWithReuseIdentifier: AssetRowCell.reuseIdentifier)
    }

    // MARK: Internal

    enum Section {
        case main
    }

}
