//
//  MasterViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    @IBOutlet var noDataView: UIView!
    
    private let viewModel = ItemsViewModel()

    //MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchData()
    }
    
    //MARK: - Private Methods
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ItemTableViewCell.toString(), bundle: nil),
                           forCellReuseIdentifier: ItemTableViewCell.toString())
        tableView.backgroundView = noDataView
    }
    
    private func fetchData() {
        viewModel.initFetch { [weak self] in
            guard let itemsCount = self?.viewModel.itemsCount else { return }
            
            self?.tableView.backgroundView = itemsCount > 0 ? nil : self?.noDataView
            self?.title = String(format: "Items: %i", itemsCount)
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
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.toString(),
                                                       for: indexPath) as? ItemTableViewCell
            else { return UITableViewCell() }
        
        let data = viewModel.getItemData(withIndex: indexPath.row)
        cell.update(withData: data)
        return cell
    }
}
