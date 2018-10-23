//
//  ErrorResult.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 23/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case url(description: String)
    case network(description: String)
    case parser(description: String)
    case other(description: String)
}
