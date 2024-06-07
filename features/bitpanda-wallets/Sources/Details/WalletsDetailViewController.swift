//
//  WalletsDetailViewController.swift
//  BitPandaWallets
//

import BitPandaCore
import BitPandaUI
import Combine
import UIKit

protocol WalletsDetailPresentableListener: AnyObject {
    func fetchWallets()
    func onDismiss()
    var dataSource: AnyPublisher<[WalletDetailRowCellModel], Never> { get }
}

private typealias WalletsDetailDataSource = UICollectionViewDiffableDataSource<
    WalletsDetailView.Section,
    WalletDetailRowCellModel
>
private typealias WalletsDetailSnapshot = NSDiffableDataSourceSnapshot<WalletsDetailView.Section, WalletDetailRowCellModel>

final class WalletsDetailViewController: ViewController<WalletsDetailView>, WalletsDetailPresentable, WalletsDetailViewControllable {

    weak var listener: WalletsDetailPresentableListener?
    
    public init(listener: WalletsDetailPresentableListener? = nil) {
        self.listener = listener
        super.init(viewCreator: WalletsDetailView.init)
    }
    
    // MARK: Public

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = Localized.title
        configureDataSource()
        setupBindings()
        addCloseButtonIfNeeded(target: self, action: #selector(handleClose))
        
        navigationController?.presentationController?.delegate = self
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.fetchWallets()
    }
    
    // MARK: Internal

    @objc
    func handleClose() {
        listener?.onDismiss()
    }

    // MARK: Private

    private var dataSource: WalletsDetailDataSource?
    private var cancellables = Set<AnyCancellable>()

    private var wallets: [WalletDetailRowCellModel] = [] {
        didSet {
            updateSnapshot(with: wallets)
        }
    }

    
    private func setupBindings() {
        listener?
            .dataSource
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
                for: indexPath) as? WalletDetailRowCell
        else { return nil }

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

extension WalletsDetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        listener?.onDismiss()
    }
}

// MARK: WalletsDetailViewController.Localized

extension WalletsDetailViewController {
    fileprivate enum Localized {
        static let title = "wallets".localize()
    }
}
