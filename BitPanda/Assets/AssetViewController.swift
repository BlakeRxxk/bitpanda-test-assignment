//
//  AssetViewController.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import BitPandaUI
import Combine
import UIKit

private typealias AssetsDataSource = UICollectionViewDiffableDataSource<AssetView.Section, Asset>
private typealias Snapshot = NSDiffableDataSourceSnapshot<AssetView.Section, Asset>

// MARK: - AssetViewController

class AssetViewController: ViewController<AssetView> {

    // MARK: Lifecycle

    init(viewModel: AssetsViewModel) {
        self.viewModel = viewModel
        super.init(viewCreator: AssetView.init)
    }

    // MARK: Internal

    let viewModel: AssetsViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Assets"
        navigationController?.navigationBar.prefersLargeTitles = true

        createData()
        configureDataSource()
        specializedView.collectionView?.delegate = self
    }

    // MARK: Private

    private var assets = [Asset]()
    private var dataSource: AssetsDataSource!

    private func configureDataSource() {
        dataSource = AssetsDataSource(
            collectionView: specializedView.collectionView!,
            cellProvider: { collectionView, indexPath, contact -> AssetRowCell? in

                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AssetRowCell.reuseIdentifier,
                    for: indexPath) as! AssetRowCell
                cell.model = contact
                return cell
            })

        var snapshot = Snapshot()
        snapshot.appendSections([AssetView.Section.main])
        snapshot.appendItems(assets)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func createData() {
        for item in 0..<10 {
            assets
                .append(Asset(
                    title: "Asset \(item)",
                    caption: "caption",
                    amount: 19.00,
                    image: UIImage(systemName: "eurosign.circle.fill")))
        }
    }
}

// MARK: UICollectionViewDelegate

extension AssetViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
        // placeholder
    }
}

// MARK: - Asset

struct Asset: Hashable {
    let title: String
    let caption: String?
    let amount: Float
    let image: UIImage?
}
