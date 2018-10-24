//
//  DetailsViewModel.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

typealias Completion = (()->())

class DetailViewModel {
    
    // MARK: - Private Properties
    
    private let apiService: APIServiceProtocool
    private let alertService: AlertService
    private var detail: Detail?

    // MARK: - Public Properties
    var itemName: String = "1"
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
    
    init(apiService: APIServiceProtocool = APIService(), alertService: AlertService = AlertService()) {
        self.apiService = apiService
        self.alertService = alertService
    }
    
    // MARK: - Networking
    
    func initFetch(successCompletion: @escaping Completion) {
        let urlString = String(format: "%@%@", Constants.itemDetailUrl, itemName)
        apiService.fetchData(url: urlString) { [weak self] result in
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
            detail = try JSONDecoder().decode(Detail.self, from: data)
        } catch {
            print(error)
        }
    }
}
