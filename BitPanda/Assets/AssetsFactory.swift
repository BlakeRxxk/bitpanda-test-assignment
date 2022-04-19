//
//  AssetsFactory.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 19.04.2022.
//

import Foundation

protocol AssetsFactory {
    func makeAssetsCoordinator() -> AssetsCoordinator
    func makeAssetsViewController() -> AssetViewController
}
