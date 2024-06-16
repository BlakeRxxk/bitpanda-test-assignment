//
//  WalletsDetailInteractor.swift
//  BitPandaWallets
//

import BitPandaCore
import Combine

// MARK: - WalletsDetailRouting

/// @mockable
public protocol WalletsDetailRouting: ViewableRouting { }

// MARK: - WalletsDetailPresentable

/// @mockable
public protocol WalletsDetailPresentable: Presentable {
    var listener: WalletsDetailPresentableListener? { get set }
}

// MARK: - WalletsDetailListener

/// @mockable
public protocol WalletsDetailListener: AnyObject {
    func onDismiss()
}

// MARK: - WalletsDetailInteractor

final class WalletsDetailInteractor: PresentableInteractor<WalletsDetailPresentable>, WalletsDetailInteractable {

    // MARK: Lifecycle

    init(
        selectedWallet: SelectedWallet,
        walletsService: WalletsServiceProtocol,
        presenter: WalletsDetailPresentable) {
        self.selectedWallet = selectedWallet
        self.walletsService = walletsService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: Internal

    weak var router: WalletsDetailRouting?
    weak var listener: WalletsDetailListener?
    @Published private(set) var internalDataStore: [WalletDetailRowCellModel] = []

    // MARK: Private

    private var walletsService: WalletsServiceProtocol
    private var selectedWallet: SelectedWallet
}

// MARK: WalletsDetailPresentableListener

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
