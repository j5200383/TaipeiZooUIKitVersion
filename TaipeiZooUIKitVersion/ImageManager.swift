//
//  ImageManager.swift
//  TaipeiZooUIKitVersion
//
//  Created by user on 2022/12/12.
//

import UIKit

class ImageManager {
    static let shared = ImageManager()
    let imageCache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func fetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = imageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        }.resume()
    }
}
