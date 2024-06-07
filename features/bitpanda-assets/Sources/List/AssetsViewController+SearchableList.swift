//
//  AssetsViewController+SearchableList.swift
//  BitPandaAssets
//

import BitPandaUI
import UIKit

// MARK: - AssetsViewController + SearchableList

extension AssetsViewController: SearchableList { }

// MARK: - AssetsViewController + UISearchResultsUpdating

extension AssetsViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) { }
}

// MARK: - AssetsViewController + UISearchBarDelegate

extension AssetsViewController: UISearchBarDelegate {
    public func searchBar(_: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        listener?.change(scope: .init(rawValue: selectedScope) ?? .all)
    }

    public func searchBar(_: UISearchBar, textDidChange searchText: String) {
        listener?.search(with: searchText)
    }

    public func searchBarCancelButtonClicked(_: UISearchBar) {
        listener?.search(with: "")
    }
}
