//
//  WalletsDetailInteractor.swift
//  BitPandaWallets
//

import BitPandaCore
import Combine

protocol WalletsDetailRouting: ViewableRouting { }

protocol WalletsDetailPresentable: Presentable {
    var listener: WalletsDetailPresentableListener? { get set }
}

protocol WalletsDetailListener: AnyObject {
    func onDismiss()
}

final class WalletsDetailInteractor: PresentableInteractor<WalletsDetailPresentable>, WalletsDetailInteractable {
    
    weak var router: WalletsDetailRouting?
    weak var listener: WalletsDetailListener?
    
    init(
        selectedWallet: SelectedWallet,
        walletsService: WalletsServiceProtocol,
        presenter: WalletsDetailPresentable) {
            self.selectedWallet = selectedWallet
            self.walletsService = walletsService
            super.init(presenter: presenter)
            presenter.listener = self
        }
    
    private var walletsService: WalletsServiceProtocol
    @Published private(set) var internalDataStore: [WalletDetailRowCellModel] = []
    private var selectedWallet: SelectedWallet
}

extension WalletsDetailInteractor: WalletsDetailPresentableListener {
    var dataSource: AnyPublisher<[WalletDetailRowCellModel], Never> {
        $internalDataStore.eraseToAnyPublisher()
    }
    
    func fetchWallets() {
        var data: [WalletDetailRowCellModel] = []

        switch selectedWallet.type {
        case .fiat:
            let precision = walletsService.fetchFiat(with: selectedWallet.selected)?.attributes.precision ?? 2
            
            data = walletsService.fetchFiatWallets()
                .filter { $0.attributes.fiatID == selectedWallet.selected }
                .map { WalletDetailRowCellModel(from: $0, precision: precision) }
        case .cryptocoin:
            
            let precision = walletsService.fetchCryptocoin(with: selectedWallet.selected)?.attributes.precisionForFiatPrice ?? 4
            
            data = walletsService.fetchWallets()
                .filter { $0.attributes.cryptocoinID == selectedWallet.selected }
                .map { WalletDetailRowCellModel(from: $0, precision: precision) }
        case .commodity:
            let precision = walletsService.fetchCommodity(with: selectedWallet.selected)?.attributes.precisionForFiatPrice ?? 4
            
            data = walletsService.fetchCommodityWallets()
                .filter { $0.attributes.cryptocoinID == selectedWallet.selected }
                .map { WalletDetailRowCellModel(from: $0, precision: precision) }
        }
        
        internalDataStore = data
    }
    
    func onDismiss() {
        listener?.onDismiss()
    }
}
