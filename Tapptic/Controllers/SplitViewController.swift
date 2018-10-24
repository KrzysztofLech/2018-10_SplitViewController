//
//  SplitViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 24/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class SplitViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    var items: [Item]!
    var detailVC: DetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setupView()
    }
    
    private func setupView() {        
        detailView.isHidden = UIDevice.current.orientation.isPortrait ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListVC", let vc = segue.destination as? MasterViewController {
            vc.items = items
            vc.delegate = self
        }
        
        if segue.identifier == "DetailVC", let vc = segue.destination as? DetailViewController {
            detailVC = vc
            vc.delegate = self
        }
    }
    
    fileprivate func refreshView(withDetailViewVisible detailVisible: Bool) {
        if currentOrientationIsPortrait() {
            listView.isHidden = detailVisible
            detailView.isHidden = !detailVisible
        } else {
            listView.isHidden = false
            detailView.isHidden = false
        }
    }
}

extension SplitViewController: ShowDetailProtocol {
    func showDetail(withName name: String) {
        detailVC.itemName = name
        refreshView(withDetailViewVisible: true)
    }
}

extension SplitViewController: HideDetailProtocol {
    func hideDetail() {
        refreshView(withDetailViewVisible: false)
    }
}
