//
//  Album.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation


struct Album {
    let albumID: Int!
    let name: String?
    let artist: String?
    let imageURL: URL?
    let imageURLHighResolution: URL?
    let releaseDate: String?
    let country: String?
    let trackCount: Int?
//    let lowResolutionKey: Int?
//    let highResolutionKey: Int?
    
    init(by resultJSON: [String: Any]) {
        let album = resultJSON
        let albumName = album["collectionName"] as? String
        let artistName = album["artistName"] as? String
        let imageURLString = album["artworkUrl100"] as? String
        let collectionId = album["collectionId"] as? Int
        let releaseDate = album["releaseDate"] as? String
        let country = album["country"] as? String
        let trackCount = album["trackCount"] as? Int
        
        name = albumName
        artist = artistName
        albumID = collectionId ?? 0
        self.releaseDate = releaseDate
        self.country = country
        self.trackCount = trackCount
        
        
        if let imageURLString = imageURLString {
            let url = URL(string: imageURLString)
            imageURL = url
            self.imageURLHighResolution = ImageManager.shared.getHighResolutionImageURL(url: url)
        } else {
            imageURL = nil
            self.imageURLHighResolution = nil
        }
    }
}
