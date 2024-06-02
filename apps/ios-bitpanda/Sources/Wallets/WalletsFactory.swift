//
//  WalletsFactory.swift
//  BitPanda
//

import BitPandaWallets
import Foundation

protocol WalletsFactory {
    func makeWalletsCoordinator() -> WalletsCoordinator
    func makeWalletsViewController() -> WalletsViewController
    func makeWalletsDetailView(_ passData: WalletsDetailViewDataPass) -> WalletsDetailViewController
}
