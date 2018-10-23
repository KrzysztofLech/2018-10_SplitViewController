//
//  AlertService.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 23/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

struct AlertService {
    
    func showAlert(withError error: ErrorResult, noInternetAction: @escaping Completion) {
        let errorDescription = error.getErrorMessage()
        switch error {
        case .noInternet:
            showNoInternetAlert(withAction: noInternetAction)
            
        default:
            showAlert(withTitle: errorDescription)
        }
    }
    
    private func showNoInternetAlert(withAction action: @escaping Completion ) {
        guard let controller = UIApplication.getPresentedViewController() else { return }
        
        let ac = UIAlertController(title: "No Internet!",
                                   message: "Check your network and try again.",
                                   preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            action()}
        ac.addAction(action)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        ac.addAction(okAction)
        
        controller.present(ac, animated: true, completion: nil)
    }
    
    private func showAlert(withTitle title: String) {
        guard let controller = UIApplication.getPresentedViewController() else { return }
        
        let ac = UIAlertController(title: title,
                                   message: nil,
                                   preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in }
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
}
