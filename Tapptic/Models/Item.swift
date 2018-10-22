//
//  Item.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct Item: Codable {
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image"
    }
}
