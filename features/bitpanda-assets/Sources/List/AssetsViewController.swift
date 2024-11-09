//
//  AssetsViewController.swift
//  BitPandaAssets
//

import BitPandaCore
import BitPandaUI
import Combine
import UIKit

private typealias AssetsDataSource = UICollectionViewDiffableDataSource<AssetView.Section, AssetCellModel>
private typealias AssetsSnapshot = NSDiffableDataSourceSnapshot<AssetView.Section, AssetCellModel>

// MARK: - AssetsPresentableListener

public protocol AssetsPresentableListener: AnyObject {
    func fetchAggregatedAssets()
    func search(with text: String)
    func change(scope index: SearchScope)

    var dataSource: AnyPublisher<[AssetCellModel], Never> { get }
}

// MARK: - AssetsViewController

final class AssetsViewController: ViewController<AssetView>, AssetsPresentable, AssetsViewControllable {

    // MARK: Lifecycle

    init(listener: AssetsPresentableListener? = nil) {
        self.listener = listener
        super.init(viewCreator: AssetView.init)
    }

    // MARK: Public

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.fetchAggregatedAssets()
        setupSearchController(with: [
            Localized.all,
            Localized.cryptocoins,
            Localized.commodities,
            Localized.fiats,
        ])
    }

    // MARK: Internal

    weak var listener: AssetsPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Localized.title.capitalized
        configureDataSource()
        setupBindings()
        specializedView.collectionView?.delegate = self
    }

    // MARK: Private

    private var cancellables = Set<AnyCancellable>()
    private var dataSource: AssetsDataSource?

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

        var snapshot = AssetsSnapshot()
        snapshot.appendSections([AssetView.Section.main])
        snapshot.appendItems(assets)
    }

    private func cellProvider(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ model: AssetCellModel)
        -> UICollectionViewCell? {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AssetRowCell.reuseIdentifier,
                for: indexPath) as? AssetRowCell
        else { return nil }
        cell.model = model
        return cell
    }

    private func setupBindings() {
        listener?
            .dataSource
            .sink { [weak self] data in
                self?.assets = data
            }
            .store(in: &cancellables)
    }

    private func updateSnapshot(with items: [AssetCellModel]) {
        var snapshot = AssetsSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension AssetsViewController {
    fileprivate enum Localized {
        static let title = "assets".localize()
        static let all = "all".localize()
        static let cryptocoins = "cryptocoins".localize()
        static let commodities = "commodities".localize()
        static let fiats = "fiats".localize()
    }
}

// MARK: UICollectionViewDelegate

extension AssetsViewController: UICollectionViewDelegate {}
