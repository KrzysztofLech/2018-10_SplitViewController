//
//  APIService.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 23/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

protocol APIServiceProtocool {
    func fetchData(url: String, completion: @escaping (Result<Data, ErrorResult>) -> Void)
}

class APIService: APIServiceProtocool {
    
    func fetchData(url: String, completion: @escaping (Result<Data, ErrorResult>) -> Void) {
        guard let endPointUrl = URL(string: url) else {
            completion(.failure(.url(description: "Wrong url format")))
            return
        }
        
        URLSession.shared.dataTask(with: endPointUrl) { (data, response, error) in
            if let error = error {
                if let err = error as? URLError, err.code == .notConnectedToInternet {
                    completion(.failure(.noInternet(description: "No Internet!")))
                } else {
                    completion(.failure(.network(description: "Failed to fetch data: " + error.localizedDescription)))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(.network(description: "Response Status Code is not OK (\(httpResponse.statusCode))")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.parser(description: "Fetched data problem")))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
