//
//  DetailsViewModel.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIServiceProtocool
    private let itemName: String
    private var detail: Detail?

    // MARK: - Public Properties
    var name: String {
        return detail?.name ?? ""
    }
    
    var text: String {
        return detail?.text ?? ""
    }
    
    var imageURL: String {
        return detail?.imageUrl ?? ""
    }
    
    // MARK: - Init
    init(itemName: String, apiService: APIServiceProtocool = APIService()) {
        self.itemName = itemName
        self.apiService = apiService
    }
    
    func initFetch(successCompletion: @escaping Completion) {
        let successHandler: (Detail)->() = { [weak self] detail in
            self?.detail = detail
            DispatchQueue.main.async { successCompletion() }
        }
        
        let errorHandler: (APIError)->() = { [weak self] error in
            print("Error: ", error.rawValue)
            // TODO: Show Allert
        }
        
        let urlString = String(format: "%@%@", Constants.itemDetailUrl, itemName)
        apiService.fetchData(url: urlString,
                             successsHandler: successHandler,
                             errorHandler: errorHandler)
    }
}
