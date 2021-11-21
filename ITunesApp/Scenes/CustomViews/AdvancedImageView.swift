//
//  AdvancedImageView.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 18.11.2021.
//

import UIKit


final class AdvancedImageView: UIImageView {
    
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.center = self.center
        activityIndicator.color = .black
    }
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    func setImage(by url: URL, forKey key: Int) {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        chooseFetchingWay(url: url, key: key) { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func chooseFetchingWay(url: URL, key: Int, completion: @escaping ()->()) {
        if !ImageManager.shared.cacheContainsImage(at: key) {
            fetchImage(url: url, forKey: key) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                    self?.fadeIn()
                    completion()
                }
                ImageManager.shared.saveImageDataToCache(with: image, forKey: key)
            }
        } else {
            ImageManager.shared.getCachedImage(for: key) { image in
                guard let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                    completion()
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
