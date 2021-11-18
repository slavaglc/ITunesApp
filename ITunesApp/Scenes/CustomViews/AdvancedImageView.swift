//
//  AdvancedImageView.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 18.11.2021.
//

import UIKit


final class AdvancedImageView: UIImageView {
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    func setImage(by url: URL, forKey key: Int) {
        if !ImageManager.shared.cacheContainsImage(at: key) {
            fetchImage(url: url, forKey: key) { image in
                DispatchQueue.main.async {
                    self.image = image
                }
                ImageManager.shared.saveImageDataToCache(with: image, forKey: key)
            }
        } else {
            ImageManager.shared.getCachedImage(for: key) { image in
                print("get from cache")
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    private func fetchImage(url: URL, forKey key: Int, completion: @escaping (UIImage)->()) {
        ImageManager.shared.fetchImage(url: url) { imageData, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "error with image loading"); return }
            guard let imageData = imageData else { return }
            guard let image = UIImage(data: imageData) else { return }
            completion(image)
        }
    }

}
