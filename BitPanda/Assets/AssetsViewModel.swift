//
//  AssetsViewModel.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 18.04.2022.
//

import Foundation
import UIKit

// MARK: - AssetsViewModel

final class AssetsViewModel {
    init() {}
}

// MARK: - AssetsViewModelState

enum AssetsViewModelState: Equatable {
    case loading
    case finishedLoading
    case error
}
