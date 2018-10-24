//
//  UIViewController+extensions.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func toString() -> String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    func currentOrientationIsPortrait() -> Bool {
        let currentOrientation = UIApplication.shared.statusBarOrientation
        if currentOrientation == .portrait || currentOrientation == .portraitUpsideDown {
            return true
        }
        return false
    }
}
