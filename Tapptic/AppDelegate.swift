//
//  AppDelegate.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard
            let splitViewController = window?.rootViewController as? UISplitViewController,
            let masterNavigationController = splitViewController.viewControllers.first as? UINavigationController,
            let masterViewController = masterNavigationController.topViewController as? MasterViewController,
            let detailNavigationController = splitViewController.viewControllers.last as? UINavigationController,
            let detailViewController = detailNavigationController.topViewController as? DetailViewController
            else { fatalError() }
        
        /// przekazać początkowe dane DetailVC
        
        /// dodać delegata do MasterVC
        
        // iPad settings
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        return true
    }
}

