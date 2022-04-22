//
//  AssetsView.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import BitPandaUI
import UIKit

public class AssetView: View {

    // MARK: Lifecycle

    override public init() {
        super.init()

        createUI()
    }

    // MARK: Internal

    enum Section {
        case main
    }

    var collectionView: UICollectionView?

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    // MARK: Private

    private func createUI() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.register(AssetRowCell.self, forCellWithReuseIdentifier: AssetRowCell.reuseIdentifier)
        collectionView?.backgroundColor = Theme.Background.primary
        
        guard let collectionView = collectionView else { return }
        addSubview(collectionView)
    }
}
