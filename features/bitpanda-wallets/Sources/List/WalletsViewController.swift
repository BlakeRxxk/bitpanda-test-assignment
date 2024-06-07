//
//  WalletsViewController.swift
//  BitPandaWallets
//

import BitPandaCore
import BitPandaUI
import Combine
import UIKit

// MARK: - WalletsPresentableListener

public protocol WalletsPresentableListener: AnyObject {
    func fetchAggregatedWallets()
    func search(with text: String)
    func change(scope index: SearchScope)
    func select(wallet: SelectedWallet)

    var dataSource: AnyPublisher<[WalletGroupCellModel], Never> { get }
}

private typealias WalletsDataSource = UICollectionViewDiffableDataSource<WalletsView.Section, WalletGroupCellModel>
private typealias Snapshot = NSDiffableDataSourceSnapshot<WalletsView.Section, WalletGroupCellModel>

// MARK: - WalletsViewController

final class WalletsViewController: ViewController<WalletsView>, WalletsPresentable, WalletsViewControllable {

    // MARK: Lifecycle

    init(listener: WalletsPresentableListener? = nil) {
        self.listener = listener
        super.init(viewCreator: WalletsView.init)
    }

    // MARK: Public

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Localized.title.capitalized
        configureDataSource()
        setupBindings()

        specializedView.collectionView?.delegate = self
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.fetchAggregatedWallets()
        setupSearchController(with: [
            Localized.all,
            Localized.cryptocoins,
            Localized.commodities,
            Localized.fiats,
        ])
    }

    // MARK: Internal

    weak var listener: WalletsPresentableListener?

    // MARK: Private

    private var dataSource: WalletsDataSource?
    private var cancellables = Set<AnyCancellable>()

    private var walletGroups: [WalletGroupCellModel] = [] {
        didSet {
            updateSnapshot(with: walletGroups)
        }
    }

    private func setupBindings() {
        listener?
            .dataSource
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
                for: indexPath) as? WalletGroupsCell
        else { return nil }
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

// MARK: UICollectionViewDelegate

extension WalletsViewController: UICollectionViewDelegate {
    public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = walletGroups[indexPath.item]
        listener?.select(wallet: .init(
            title: cell.title,
            selected: cell.itemID,
            type: cell.type))
    }
}

// MARK: WalletsViewController.Localized

extension WalletsViewController {
    fileprivate enum Localized {
        static let title = "wallets".localize()
        static let all = "all".localize()
        static let cryptocoins = "cryptocoins".localize()
        static let commodities = "commodities".localize()
        static let fiats = "fiats".localize()
    }
}
