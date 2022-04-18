//
//  WalletsViewController.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import UIKit

class WalletsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Wallets"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
