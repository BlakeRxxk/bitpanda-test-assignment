//
//  WalletsViewController+SearchableList.swift
//  BitPandaWallets
//

import BitPandaUI
import UIKit

// MARK: - WalletsViewController + SearchableList

extension WalletsViewController: SearchableList { }

// MARK: - WalletsViewController + UISearchResultsUpdating

extension WalletsViewController: UISearchResultsUpdating {
    public func updateSearchResults(for _: UISearchController) { }
}

// MARK: - WalletsViewController + UISearchBarDelegate

extension WalletsViewController: UISearchBarDelegate {
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
