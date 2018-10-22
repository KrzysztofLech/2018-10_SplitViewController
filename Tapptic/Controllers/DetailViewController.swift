//
//  DetailViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var mainActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemTextLabel: UILabel!
    
    var itemName: String = "1"
    
    lazy private var viewModel = DetailViewModel(itemName: itemName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.alpha = 0.0
        fetchData()
    }
    
    private func fetchData() {
        viewModel.initFetch { [weak self] in
            self?.mainActivityIndicator.stopAnimating()
            self?.configureView()
            UIView.animate(withDuration: 0.8, animations: {
                self?.containerView.alpha = 1.0
            })
        }
    }
    
    private func configureView() {
        itemNameLabel.text = viewModel.name
        itemTextLabel.text = viewModel.text
        
        ImageService.getImage(withUrl: viewModel.imageURL) { [weak self] (image) in
            self?.imageActivityIndicator.stopAnimating()
            self?.itemImageView.image = image
        }
    }
}
