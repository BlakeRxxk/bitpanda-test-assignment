//
//  AssetsView.swift
//  BitPandaAssets
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
