//
//  MasterViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    private let viewModel = ItemsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        fetchData()
    }
    
    private func fetchData() {
        viewModel.initFetch { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Table View Data Souce Methods

extension MasterViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterVCcell", for: indexPath)
        
        return cell
    }
}
