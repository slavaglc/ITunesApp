//
//  Song.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 20.11.2021.

struct Song {
    let trackName: String?
    let trackTimeMillis: Int?
    
    init(by resultJSON: [String: Any]) {
        let song = resultJSON
        trackName = song["trackName"] as? String
        trackTimeMillis = song["trackTimeMillis"] as? Int
    }
}
