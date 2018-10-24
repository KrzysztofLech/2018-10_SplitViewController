//
//  DetailViewController.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol HideDetailProtocol {
    func hideDetail()
}

class DetailViewController: UIViewController {

    @IBOutlet private weak var backToListButton: UIButton!
    @IBOutlet private weak var mainActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemTextLabel: UILabel!
    
    var delegate: HideDetailProtocol!
    
    var itemName: String = "1" {
        didSet {
            viewModel.itemName = itemName
            showNewData()
        }
    }
    
    private var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNewData()
    }
    
    private func showNewData() {
        containerView.alpha = 0.0
        mainActivityIndicator.startAnimating()
        resetView()
        fetchData()
    }
    
    private func resetView() {
        itemNameLabel.text = nil
        itemTextLabel.text = nil
        imageActivityIndicator.startAnimating()
        itemImageView.image = nil
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
    
    @IBAction func backToListButtonAction() {
        delegate.hideDetail()
    }
}
