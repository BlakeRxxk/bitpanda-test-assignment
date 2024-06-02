//
//  WalletsView.swift
//  WalletsFeature
//

import BitPandaUI
import UIKit

public class WalletsView: BaseListView {

    // MARK: Public

    override public func createUI() {
        super.createUI()

        collectionView?.register(
            WalletGroupsCell.self,
            forCellWithReuseIdentifier: WalletGroupsCell.reuseIdentifier)
    }

    // MARK: Internal

    enum Section {
        case main
    }

}
