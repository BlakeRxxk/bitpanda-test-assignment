//
//  WalletsFactory.swift
//  BitPanda
//

import Foundation
import WalletsFeature

protocol WalletsFactory {
    func makeWalletsCoordinator() -> WalletsCoordinator
    func makeWalletsViewController() -> WalletsViewController
    func makeWalletsDetailView(_ passData: WalletsDetailViewDataPass) -> WalletsDetailViewController
}
