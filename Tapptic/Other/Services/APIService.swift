//
//  APIService.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case urlError = "Cannot create URL"
    case noInternetError = "No Internet!"
    case fetchError = "Failed to fetch data"
    case responseError = "Response Status Code is not OK"
    case dataError = "Fetched data problem"
    case decodeError = "JSON decoding problem"
}

protocol APIServiceProtocool {
    func fetchData<T: Decodable>(url: String, successsHandler: @escaping (T)->(), errorHandler: @escaping (APIError)->())
}

class APIService: APIServiceProtocool {
    
    func fetchData<T: Decodable>(url: String, successsHandler: @escaping (T)->(), errorHandler: @escaping (APIError)->()) {
        guard let endPointUrl = URL(string: url) else {
            print("Error: ", APIError.urlError.rawValue)
            errorHandler(APIError.urlError)
            return
        }
        
        URLSession.shared.dataTask(with: endPointUrl) { (data, response, error) in
            if let error = error {
                if let err = error as? URLError, err.code == .notConnectedToInternet {
                    print("Error: ", APIError.noInternetError.rawValue)
                    errorHandler(APIError.noInternetError)
                } else {
                    print("Error: \(APIError.fetchError.rawValue) - ", error.localizedDescription)
                    errorHandler(APIError.fetchError)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Error: \(APIError.responseError.rawValue). StatusCode: \(httpResponse.statusCode)")
                errorHandler(APIError.responseError)
                return
            }
            
            guard let data = data else {
                print("Error: ", APIError.dataError.rawValue)
                errorHandler(APIError.dataError)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                print("Response data: ", decodedData)
                successsHandler(decodedData)
                
            } catch let error {
                print("Error: ", APIError.decodeError.rawValue, error.localizedDescription)
                errorHandler(APIError.decodeError)
            }
            }.resume()
    }
}
