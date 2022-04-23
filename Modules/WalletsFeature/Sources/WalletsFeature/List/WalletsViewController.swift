//
//  WalletsViewController.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 21.04.2022.
//

import BitPandaCore
import BitPandaUI
import Combine
import UIKit

private typealias WalletsDataSource = UICollectionViewDiffableDataSource<WalletsView.Section, WalletGroupCellModel>
private typealias Snapshot = NSDiffableDataSourceSnapshot<WalletsView.Section, WalletGroupCellModel>

// MARK: - WalletsViewControllerOutput

public protocol WalletsViewControllerOutput: AnyObject {
    func presentDetailView(_ passData: WalletsDetailViewDataPass)
}

// MARK: - WalletsViewController

public class WalletsViewController: ViewController<WalletsView> {

    // MARK: Lifecycle

    public init(viewModel: WalletsViewModel) {
        self.viewModel = viewModel
        super.init(viewCreator: WalletsView.init)
    }

    // MARK: Public

    public weak var output: WalletsViewControllerOutput?

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        configureDataSource()
        setupBindings()

        specializedView.collectionView?.delegate = self
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAggregatedWallets()
        setupSearchController(with: [
            Localized.all,
            Localized.cryptocoins,
            Localized.commodities,
            Localized.fiats,
        ])
    }

    // MARK: Private

    private var viewModel: WalletsViewModel
    private var dataSource: WalletsDataSource?
    private var cancellables = Set<AnyCancellable>()

    private var walletGroups: [WalletGroupCellModel] = [] {
        didSet {
            updateSnapshot(with: walletGroups)
        }
    }

    private func setupBindings() {
        viewModel
            .$title
            .sink { self.title = $0 }
            .store(in: &cancellables)

        viewModel
            .$dataSource
            .sink { self.walletGroups = $0 }
            .store(in: &cancellables)
    }

    private func configureDataSource() {
        guard let collectionView = specializedView.collectionView else { return }
        dataSource = WalletsDataSource(
            collectionView: collectionView,
            cellProvider: cellProvider)

        var snapshot = Snapshot()
        snapshot.appendSections([WalletsView.Section.main])
        snapshot.appendItems(walletGroups)
    }

    private func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ model: WalletGroupCellModel)
        -> UICollectionViewCell? {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WalletGroupsCell.reuseIdentifier,
                for: indexPath) as? WalletGroupsCell else { return nil }
        cell.model = model
        return cell
    }

    private func updateSnapshot(with items: [WalletGroupCellModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: SearchableList

extension WalletsViewController: SearchableList {}

// MARK: UICollectionViewDelegate

extension WalletsViewController: UICollectionViewDelegate {
    public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = walletGroups[indexPath.item]

        output?.presentDetailView(.init(title: cell.title, selected: cell.itemID, type: cell.type))
    }
}

// MARK: UISearchResultsUpdating

extension WalletsViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) {}
}

// MARK: UISearchBarDelegate

extension WalletsViewController: UISearchBarDelegate {
    public func searchBar(_: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.change(scope: .init(rawValue: selectedScope) ?? .all)
    }

    public func searchBar(_: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }

    public func searchBarCancelButtonClicked(_: UISearchBar) {
        viewModel.search(with: "")
    }
}

extension WalletsViewController {
    fileprivate enum Localized {
        static let all = "All"
        static let cryptocoins = "Cryptocoins"
        static let commodities = "Commodities"
        static let fiats = "Fiats"
    }
}
