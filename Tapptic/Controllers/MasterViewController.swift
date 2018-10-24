//
//  MasterViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol ShowDetailProtocol {
    func showDetail(withName name: String)
}

class MasterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemsCounterLabel: UILabel!
    
    var items: [Item] = []
    var delegate: ShowDetailProtocol!
    
    fileprivate var selectedCellIndex: Int = 0 {
        didSet {
            if let oldCell = tableView.cellForRow(at: IndexPath(row: oldValue, section: 0)) as? ItemTableViewCell {
                oldCell.state = .notSelected
            }

            if let newCell = tableView.cellForRow(at: IndexPath(row: selectedCellIndex, section: 0)) as? ItemTableViewCell {
                newCell.state = .selected
            }
        }
    }
    
    //MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupItemsCounter()
        tableView.reloadData()
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ItemTableViewCell.toString(), bundle: nil),
                           forCellReuseIdentifier: ItemTableViewCell.toString())
    }
    
    private func setupItemsCounter() {
        itemsCounterLabel.text = String(format: "Items: %i", items.count)
    }
}

// MARK: - Table View Data Souce Methods

extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.toString(),
                                                       for: indexPath) as? ItemTableViewCell
            else { return UITableViewCell() }
        
        let data = items[indexPath.row]
        cell.update(withData: data)
        cell.state = selectedCellIndex == indexPath.row ? .selected : .notSelected
        
        ImageService.getImage(withUrl: data.imageUrl) { (image) in
            if cell.thumbnailURL == data.imageUrl {
                cell.activityIndicator.stopAnimating()
                cell.thumbnailImageView.image = image
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Table View Delegate Methods

extension MasterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.row
        delegate.showDetail(withName: items[indexPath.row].name)
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
        cell.state = .touched
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
        cell.state = selectedCellIndex == indexPath.row ? .selected : .notSelected
    }
}
