//
//  WalletsDetailView.swift
//  WalletsFeature
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
