//
//  WalletsInteractor.swift
//  BitPandaWallets
//

import BitPandaCore
import Combine

// MARK: - WalletsRouting

public protocol WalletsRouting: ViewableRouting {
    func attachDetailView(with model: SelectedWallet)
    func detachWalletDetail()
}

// MARK: - WalletsPresentable

public protocol WalletsPresentable: Presentable {
    var listener: WalletsPresentableListener? { get set }
}

// MARK: - WalletsListener

public protocol WalletsListener: AnyObject { }

// MARK: - WalletsInteractor

final class WalletsInteractor: PresentableInteractor<WalletsPresentable> {

    // MARK: Lifecycle

    init(
        walletsService: WalletsServiceProtocol,
        presenter: WalletsPresentable) {
        self.walletsService = walletsService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: WalletsRouting?
    weak var listener: WalletsListener?

    // MARK: Private

    @Published private var internalDataStore: [WalletGroupCellModel] = []
    private var walletsService: WalletsServiceProtocol
    private var cache: [WalletGroupCellModel] = []
    private var selectedScope: SearchScope = .all
    private var searchString = ""

    private func applyFilter() {
        var data: [WalletGroupCellModel] = cache

        if selectedScope != .all {
            data = data.filter { $0.type == selectedScope.cellType }
        }

        if !searchString.isEmpty {
            data = data.filter { applySearch(for: searchString, in: $0.title) }
        }

        internalDataStore = data
    }

    private func applySearch(for item: String, in stack: String) -> Bool {
        Fuzzy.search(needle: item, haystack: stack)
    }
}

// MARK: WalletsPresentableListener

extension WalletsInteractor: WalletsPresentableListener {

    // MARK: Public

    public func change(scope index: SearchScope) {
        selectedScope = index
        applyFilter()
    }

    public func search(with text: String) {
        searchString = text
        applyFilter()
    }

    public func select(wallet: SelectedWallet) {
        router?.attachDetailView(with: wallet)
    }

    // MARK: Internal

    var dataSource: AnyPublisher<[WalletGroupCellModel], Never> {
        $internalDataStore.eraseToAnyPublisher()
    }

    func fetchAggregatedWallets() {
        let wallets = walletsService
            .fetchWallets()
            .group(by: \.attributes.cryptocoinID)
            .map { WalletGroupCellModel(from: $0) }

        let commodities = walletsService
            .fetchCommodityWallets()
            .group(by: \.attributes.cryptocoinID)
            .map { WalletGroupCellModel(from: $0, isCommodity: true) }

        let fiats = walletsService
            .fetchFiatWallets()
            .group(by: \.attributes.fiatID)
            .map { WalletGroupCellModel(from: $0) }

        let result = wallets + commodities + fiats
        cache = result
        internalDataStore = result
    }

}

// MARK: WalletsInteractable

extension WalletsInteractor: WalletsInteractable {
    func onDismiss() {
        router?.detachWalletDetail()
    }
}
