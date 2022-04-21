//
//  AssetsViewController.swift
//  AssetsFeature
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import BitPandaCore
import BitPandaUI
import Combine
import UIKit

private typealias AssetsDataSource = UICollectionViewDiffableDataSource<AssetView.Section, AssetCellModel>
private typealias Snapshot = NSDiffableDataSourceSnapshot<AssetView.Section, AssetCellModel>

// MARK: - AssetsViewController

public class AssetsViewController: ViewController<AssetView> {

    // MARK: Lifecycle

    public init(viewModel: AssetsViewModel) {
        self.viewModel = viewModel
        super.init(viewCreator: AssetView.init)
    }

    // MARK: Public

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        configureDataSource()
        setupBindings()
        specializedView.collectionView?.delegate = self
        setupSearchController()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAggregatedAssets()
    }

    // MARK: Internal

    let viewModel: AssetsViewModel

    // MARK: Private

    private var dataSource: AssetsDataSource?
    private var cancellables = Set<AnyCancellable>()

    private var assets: [AssetCellModel] = [] {
        didSet {
            updateSnapshot(with: assets)
        }
    }

    private func configureDataSource() {
        guard let collectionView = specializedView.collectionView else { return }
        dataSource = AssetsDataSource(
            collectionView: collectionView,
            cellProvider: cellProvider)

        var snapshot = Snapshot()
        snapshot.appendSections([AssetView.Section.main])
        snapshot.appendItems(assets)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ model: AssetCellModel)
        -> UICollectionViewCell? {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AssetRowCell.reuseIdentifier,
                for: indexPath) as? AssetRowCell else { return nil }
        cell.model = model
        return cell
    }

    private func setupBindings() {
        viewModel
            .$dataSource
            .sink { self.assets = $0 }
            .store(in: &cancellables)

        viewModel
            .$title
            .sink { self.title = $0 }
            .store(in: &cancellables)
    }

    private func updateSnapshot(with items: [AssetCellModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func setupSearchController() {

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = [
            Localized.all,
            Localized.cryptocoins,
            Localized.commodities,
            Localized.fiats,
        ]

        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
}

// MARK: UICollectionViewDelegate

extension AssetsViewController: UICollectionViewDelegate {
    public func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
        // placeholder
    }

    public func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt _: IndexPath) {
        guard let cell = cell as? AssetRowCell else { return }
        cell.loadImage()
    }
}

// MARK: UISearchResultsUpdating

extension AssetsViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) {}
}

// MARK: UISearchBarDelegate

extension AssetsViewController: UISearchBarDelegate {
    public func searchBar(_: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.change(scope: .init(rawValue: selectedScope) ?? .all)
    }

    public func searchBar(_: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }
}

extension AssetsViewController {
    fileprivate enum Localized {
        static let all = "All"
        static let cryptocoins = "Cryptocoins"
        static let commodities = "Commodities"
        static let fiats = "Fiats"
    }
}
