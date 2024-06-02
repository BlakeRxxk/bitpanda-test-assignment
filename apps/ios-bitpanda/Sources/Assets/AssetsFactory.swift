//
//  AssetsFactory.swift
//  BitPanda
//

import BitPandaAssets
import Foundation

protocol AssetsFactory {
    func makeAssetsCoordinator() -> AssetsCoordinator
    func makeAssetsViewController() -> AssetsViewController
}
