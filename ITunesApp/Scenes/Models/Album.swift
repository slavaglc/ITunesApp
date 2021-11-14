//
//  Album.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation


struct Album {
    let name: String?
    let artist: String?
    let imageURL: URL?
    
    init(by resultJSON: [String: Any]) {
        let album = resultJSON
        let albumName = album["collectionName"] as? String
        let artistName = album["artistName"] as? String
        let imageURLString = album["artworkUrl100"] as? String
        
        name = albumName
        artist = artistName
        
        if let imageURLString = imageURLString {
            imageURL = URL(string: imageURLString)
        } else {
            imageURL = nil
        }
        
    }
}
