//
//  AssetsInteractor.swift
//  BitPandaAssets
//

import BitPandaCore
import Combine

// MARK: - AssetsRouting

public protocol AssetsRouting: ViewableRouting {}

// MARK: - AssetsPresentable

protocol AssetsPresentable: Presentable {
    var listener: AssetsPresentableListener? { get set }
}

// MARK: - AssetsListener

public protocol AssetsListener: AnyObject {}

// MARK: - AssetsInteractor

final class AssetsInteractor: PresentableInteractor<AssetsPresentable>, AssetsInteractable {

    // MARK: Lifecycle

    init(
        assetsService: AssetsServiceProtocol,
        presenter: AssetsPresentable) {
        self.assetsService = assetsService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: AssetsRouting?
    weak var listener: AssetsListener?

    // MARK: Private

    @Published private var internalDataStore: [AssetCellModel] = []

    private var assetsService: AssetsServiceProtocol
    private var cache: [AssetCellModel] = []
    private var selectedScope: SearchScope = .all
    private var searchString = ""
    
    private func applyFilter() {
        var data: [AssetCellModel] = cache
        
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

// MARK: AssetsPresentableListener

extension AssetsInteractor: AssetsPresentableListener {
    var dataSource: AnyPublisher<[AssetCellModel], Never> {
        $internalDataStore.eraseToAnyPublisher()
    }

    func fetchAggregatedAssets() {
        var data: [AssetCellModel] = []
        data.append(contentsOf: assetsService.fetchCryptocoins().mapToCellModel())
        data.append(contentsOf: assetsService.fetchCommodities().mapToCellModel())
        data.append(contentsOf: assetsService.fetchFiats().mapToCellModel())
        cache = data
        internalDataStore = data
    }
    
    public func change(scope index: SearchScope) {
        selectedScope = index
        applyFilter()
    }
    
    public func search(with text: String) {
        searchString = text
        applyFilter()
    }
}
