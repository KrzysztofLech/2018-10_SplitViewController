//
//  ImageService.swift
//  Tapptic
//
//  Created by Krzysztof Lech on 22/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

struct ImageService {
    
    static func getImage(withUrl urlString: String, closure: @escaping (_ image: UIImage) -> ()) {
        if let image = CacheService.shared.getFromCache(key: urlString) as? UIImage {
            closure(image)
        } else {
            downloadImage(withUrl: urlString, closure: closure)
        }
    }
    
    private static func downloadImage(withUrl urlString: String, closure: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }

        let downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                CacheService.shared.cache(object: image, forKey: urlString)
                DispatchQueue.main.async {
                    closure(image)
                }
            }
        }
        downloadTask.resume()
    }
}
