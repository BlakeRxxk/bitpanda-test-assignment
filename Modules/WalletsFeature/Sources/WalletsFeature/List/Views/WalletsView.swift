//
//  WalletsView.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 21.04.2022.
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
