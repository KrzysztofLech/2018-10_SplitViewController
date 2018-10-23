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
    private let alertService: AlertService
    private var items: [Item] = []
    
    // MARK: - Public Properties
    
    var itemsCount: Int { return items.count }
    
    // MARK: - Init

    init(apiService: APIServiceProtocool = APIService(), alertService: AlertService = AlertService()) {
        self.apiService = apiService
        self.alertService = alertService
    }
    
    // MARK: - Networking
    
    func initFetch(successCompletion: @escaping Completion) {
        apiService.fetchData(url: Constants.itemsUrl) { [weak self] result in
            switch result {
            case .success(let data):
                self?.processFetchedData(data)
                DispatchQueue.main.async { successCompletion() }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.alertService.showAlert(withError: error, noInternetAction: {
                        self?.initFetch(successCompletion: successCompletion)
                    })
                }
            }
        }
    }
    
    private func processFetchedData(_ data: Data) {
        do {
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print(error)
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
