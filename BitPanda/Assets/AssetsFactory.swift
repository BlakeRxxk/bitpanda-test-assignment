//
//  AssetsFactory.swift
//  BitPanda
//

import AssetsFeature
import Foundation

protocol AssetsFactory {
    func makeAssetsCoordinator() -> AssetsCoordinator
    func makeAssetsViewController() -> AssetsViewController
}
