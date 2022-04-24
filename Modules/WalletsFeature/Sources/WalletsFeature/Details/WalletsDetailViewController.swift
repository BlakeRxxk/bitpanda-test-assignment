//
//  WalletsDetailViewController.swift
//  WalletsFeature
//
//  Created by Oleg Kurgaev on 23.04.2022.
//

import BitPandaCore
import BitPandaUI
import Combine
import UIKit

private typealias WalletsDetailDataSource = UICollectionViewDiffableDataSource<
    WalletsDetailView.Section,
    WalletDetailRowCellModel
>
private typealias WalletsDetailSnapshot = NSDiffableDataSourceSnapshot<WalletsDetailView.Section, WalletDetailRowCellModel>

// MARK: - WalletsDetailViewController

public class WalletsDetailViewController: ViewController<WalletsDetailView> {

    // MARK: Lifecycle

    public init(viewModel: WalletsDetailViewModel) {
        self.viewModel = viewModel
        super.init(viewCreator: WalletsDetailView.init)
    }

    // MARK: Public

    override public func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
        setupBindings()
        addCloseButtonIfNeeded(target: self, action: #selector(handleClose))
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchWallets()
    }

    // MARK: Internal

    @objc
    func handleClose() {
        dismiss(animated: true)
    }

    // MARK: Private

    private var dataSource: WalletsDetailDataSource?
    private var viewModel: WalletsDetailViewModel
    private var cancellables = Set<AnyCancellable>()

    private var wallets: [WalletDetailRowCellModel] = [] {
        didSet {
            updateSnapshot(with: wallets)
        }
    }

    private func setupBindings() {
        viewModel
            .$title
            .sink { self.title = $0 }
            .store(in: &cancellables)

        viewModel
            .$dataSource
            .sink { self.wallets = $0 }
            .store(in: &cancellables)
    }

    private func configureDataSource() {
        guard let collectionView = specializedView.collectionView else { return }
        dataSource = WalletsDetailDataSource(
            collectionView: collectionView,
            cellProvider: cellProvider)

        var snapshot = WalletsDetailSnapshot()
        snapshot.appendSections([WalletsDetailView.Section.main])
        snapshot.appendItems(wallets)
    }

    private func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ model: WalletDetailRowCellModel)
        -> UICollectionViewCell? {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WalletDetailRowCell.reuseIdentifier,
                for: indexPath) as? WalletDetailRowCell else { return nil }
        cell.model = model
        return cell
    }

    private func updateSnapshot(with items: [WalletDetailRowCellModel]) {
        var snapshot = WalletsDetailSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
