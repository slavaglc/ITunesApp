//
//  ImageManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import UIKit


public final class ImageManager {
    static let shared = ImageManager()
    private let imageCache = NSCache<NSNumber, UIImage>()
    
    private init() {
        let maxImagesForCache = 300
        let memoryLimit =  150 * 1024 * 1024
        imageCache.countLimit = maxImagesForCache
        imageCache.totalCostLimit = memoryLimit
    }
    
    public func fetchImage(url: URL, completion: @escaping (Data?, Error?)->()) {
        DispatchQueue.global(qos: .background).async {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data else { completion(data, error); return }
                    DispatchQueue.main.async {
                        completion(data, error)
                    }
                }.resume()
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
    
    public func getHighResolutionImageURL(url: URL?) -> URL? {
        guard let url = url else { return url } //Возвращаем старый URL, если нет 600x600 версии
        let imagePathComponent = url.lastPathComponent
        let highResolutionPathComponent = imagePathComponent.replacingOccurrences(of: "100x100", with: "600x600")
        let pathWithoutImage = url.deletingLastPathComponent()
        let newURL = pathWithoutImage.appendingPathComponent(highResolutionPathComponent)
        return newURL
    }
    
}
