//
//  WalletsFactory.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 22.04.2022.
//

import Foundation
import WalletsFeature

protocol WalletsFactory {
    func makeWalletsCoordinator() -> WalletsCoordinator
    func makeWalletsViewController() -> WalletsViewController
    func makeWalletsDetailView(_ passData: WalletsDetailViewDataPass) -> WalletsDetailViewController
}
