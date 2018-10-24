//
//  StartViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 24/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var downloadingInfoView: UIView!
    
    private let apiService = APIService()
    private let alertService = AlertService()
    private var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFetch { [weak self] in
            self?.downloadingInfoView.isHidden = true
            self?.performSegue(withIdentifier: "ShowSplitVC", sender: nil)
        }
    }
    
    func initFetch(successCompletion: @escaping Completion) {
        apiService.fetchData(url: Constants.itemsUrl) { [weak self] result in
            switch result {
            case .success(let data):
                self?.processFetchedData(data)
                DispatchQueue.main.async { successCompletion() }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.alertService.showAlert(withError: error, noInternetAction: {
                        self?.initFetch(successCompletion: successCompletion)
                    })
                }
            }
        }
    }
    
    private func processFetchedData(_ data: Data) {
        do {
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowSplitVC",
            let vc = segue.destination as? SplitViewController
            else { return }
        
        vc.items = items
    }
}
