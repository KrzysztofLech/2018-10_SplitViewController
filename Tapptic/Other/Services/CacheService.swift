//
//  CacheService.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

enum CacheConfiguration {
    static let maxObjects = 52 * 2
    static let maxSize = 300 * 100 * maxObjects
}

class CacheService {
    static let shared = CacheService()
    
    private var cache: NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.countLimit = CacheConfiguration.maxObjects
        cache.totalCostLimit = CacheConfiguration.maxSize
        return cache
    }()
    
    private init() { }
    
    func cache(object: AnyObject, forKey key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func getFromCache(key: String) -> AnyObject? {
        return cache.object(forKey: key as NSString)
    }
}
