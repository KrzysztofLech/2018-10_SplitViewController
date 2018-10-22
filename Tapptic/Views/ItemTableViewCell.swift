//
//  ItemTableViewCell.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

enum CellState {
    case touched, selected, notSelected
}

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailURL: String = ""
    var state: CellState = .notSelected {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    private func resetCell() {
        thumbnailImageView.image = nil
        titleLabel.text = nil
        activityIndicator.startAnimating()
        state = .notSelected
    }
    
    func update(withData data: Item) {
        titleLabel.text = data.name
        thumbnailURL = data.imageUrl
    }
    
    private func setupView() {
        switch state {
        case .touched:
            containerView.backgroundColor = .blue
            titleLabel.textColor = .white
            
        case .selected:
            containerView.backgroundColor = .red
            titleLabel.textColor = .white

        case .notSelected:
            containerView.backgroundColor = .white
            titleLabel.textColor = .black
        }
    }
}
