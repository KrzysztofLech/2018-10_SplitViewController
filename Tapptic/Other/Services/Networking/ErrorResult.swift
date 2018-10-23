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
    case noInternet(description: String)
    case network(description: String)
    case parser(description: String)
    case other(description: String)
}

extension ErrorResult {
    func getErrorMessage() -> String {
        switch self {
            
        case .noInternet(let description): return description
        case .network(let description): return description
            
        default:
            return "Problem with connecting to server!"
        }
    }
}
