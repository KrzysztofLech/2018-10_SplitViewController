//
//  ItemsViewModel.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

typealias Completion = (()->())

class ItemsViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIServiceProtocool
    private var items: [Item] = []
    
    // MARK: - Public Properties
    var itemsCount: Int { return items.count }
    
    // MARK: - Init

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - Networking
    
    func initFetch(successCompletion: @escaping Completion) {
        let successHandler: ([Item])->() = { [weak self] items in
            self?.processFetchedData(items: items)
            DispatchQueue.main.async { successCompletion() }
        }
        
        let errorHandler: (APIError)->() = { [weak self] error in
            print("Error: ", error.rawValue)
            // TODO: Show Allert
        }
        
        apiService.fetchData(url: Constants.itemsUrl,
                             successsHandler: successHandler,
                             errorHandler: errorHandler)
    }
    
    // MARK: - Data Model Methods
    
    private func processFetchedData(items: [Item]) {
        print("Pobrano: \(items.count) elementów!")
        self.items = items
    }
    
    func getItemData(withIndex index: Int) -> Item {
        return items[index]
    }
}
