//
//  Result.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 23/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
