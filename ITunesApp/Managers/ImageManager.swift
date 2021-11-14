//
//  ImageManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation


public final class ImageManager {
    static let shared = ImageManager()
    
    func fetchImage(url: URL, completion: @escaping (Data)->()) {
        let mainGroup = DispatchGroup()
        DispatchQueue.global(qos: .background).async {
            mainGroup.enter()
            guard let imageData = try? Data(contentsOf: url) else { return }
            mainGroup.leave()
        
            mainGroup.notify(queue: .main) {
                completion(imageData)
            }
        }
    }
}
