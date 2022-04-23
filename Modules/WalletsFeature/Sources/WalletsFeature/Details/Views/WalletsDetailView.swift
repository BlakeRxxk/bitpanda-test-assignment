//
//  WalletsDetailView.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import BitPandaUI
import UIKit

public class WalletsDetailView: BaseListView {

    // MARK: Public

    override public func createUI() {
        super.createUI()

        collectionView?.register(WalletDetailRowCell.self, forCellWithReuseIdentifier: WalletDetailRowCell.reuseIdentifier)
    }

    // MARK: Internal

    enum Section {
        case main
    }

}
