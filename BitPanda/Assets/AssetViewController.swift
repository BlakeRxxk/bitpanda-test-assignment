//
//  AssetViewController.swift
//  BitPanda
//
//  Created by Oleg Kurgaev on 12.04.2022.
//

import UIKit

class AssetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Assets"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
