//
//  ImageManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation
import UIKit


public final class ImageManager {
    static let shared = ImageManager()
    private let imageCache = NSCache<NSNumber, UIImage>()
    
    public func fetchImage(url: URL, completion: @escaping (Data?, Error?)->()) {
        let mainGroup = DispatchGroup()
        var error: Error?
        var imageData: Data?
        DispatchQueue.global(qos: .background).async {
            mainGroup.enter()
            do {
                imageData = try Data(contentsOf: url)
                mainGroup.leave()
            } catch let dataError {
                error = dataError
                mainGroup.leave()
            }
           
            mainGroup.notify(queue: .main) {
                completion(imageData, error)
            }
        }
    }
    
    
    public func saveImageDataToCache(with image: UIImage, forKey key: Int) {
        let key = NSNumber(value: key)
        imageCache.setObject(image, forKey: key)
    }
    
    public func getCachedImage(for key: Int, completion: (UIImage?)->()) {
        let key = NSNumber(value: key)
        let cachedImage = imageCache.object(forKey: key)
        completion(cachedImage)
    }
    
    public func cacheContainsImage(at key: Int) -> Bool {
        imageCache.object(forKey: NSNumber(value: key)) != nil ? true : false
    }
    
}
