//
//  StartViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 24/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(2)
        performSegue(withIdentifier: "ShowSplitVC", sender: nil)
    }
}
