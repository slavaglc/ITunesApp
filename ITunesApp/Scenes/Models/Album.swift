//
//  Album.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation


struct Album {
    let albumID: Int?
    let name: String?
    let artist: String?
    let imageURL: URL?
    let releaseDate: String?
    let country: String?
    
    init(by resultJSON: [String: Any]) {
        let album = resultJSON
        let albumName = album["collectionName"] as? String
        let artistName = album["artistName"] as? String
        let imageURLString = album["artworkUrl100"] as? String
        let collectionId = album["collectionId"] as? Int
        let releaseDate = album["releaseDate"] as? String
        let country = album["country"] as? String
        
        name = albumName
        artist = artistName
        albumID = collectionId
        self.releaseDate = releaseDate
        self.country = country
        
        if let imageURLString = imageURLString {
            imageURL = URL(string: imageURLString)
        } else {
            imageURL = nil
        }
        
    }
}
