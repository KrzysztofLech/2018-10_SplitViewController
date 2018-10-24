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
}
