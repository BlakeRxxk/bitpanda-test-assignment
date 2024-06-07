//
//  SelectedWalletStream.swift
//  BitPandaWallets
//

import Foundation
import Combine

// MARK: - SelectedWalletPublisher

protocol SelectedWalletPublisher {
    var selectedWallet: AnyPublisher<SelectedWallet, Never> { get }
}

// MARK: - MutableSelectedWalletPublisher

protocol MutableSelectedWalletPublisher: SelectedWalletPublisher {
    func updateSelected(wallet model: SelectedWallet?)
}

// MARK: - SelectedUserModelStreamImpl

final class SelectedWalletPublisherImplementation: MutableSelectedWalletPublisher {
    
    // MARK: - Properties
    
    var selectedWallet: AnyPublisher<SelectedWallet, Never> {
        self.selectedWalletSubject.compactMap { $0 }.eraseToAnyPublisher()
    }

    private let selectedWalletSubject = CurrentValueSubject<SelectedWallet?, Never>(nil)
    
    // MARK: - Internal methods
    
    func updateSelected(wallet model: SelectedWallet?) {
        selectedWalletSubject.send(model)
    }
}
