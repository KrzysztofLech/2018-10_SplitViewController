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

    init(apiService: APIServiceProtocool = APIService()) {
        self.apiService = apiService
    }
    
    // MARK: - Networking
    
    func initFetch(successCompletion: @escaping Completion) {
        apiService.fetchData(url: Constants.itemsUrl) { [weak self] result in
            do {
                self?.items = try result.decode() as [Item]
                DispatchQueue.main.async { successCompletion() }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Public Methods
    
    func getItemData(withIndex index: Int) -> Item {
        return items[index]
    }
    
    func getItemName(withIndex index: Int) -> String {
        return items[index].name
    }
}
