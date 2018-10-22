//
//  ItemTableViewCell.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailURL: String = ""
    
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
    }
    
    func update(withData data: Item) {
        titleLabel.text = data.name
        thumbnailURL = data.imageUrl
    }
}
