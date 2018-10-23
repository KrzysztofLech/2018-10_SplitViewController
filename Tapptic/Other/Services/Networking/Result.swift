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

extension Result {
    func resolve() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

extension Result where Value == Data {
    func decode<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }
}
