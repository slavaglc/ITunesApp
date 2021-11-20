//
//  NetworkManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation


public final class NetworkManager {
    
    static let shared = NetworkManager()
    private let API =  "https://itunes.apple.com/search?term=billy+talent&entity=album"
    private let host = "itunes.apple.com"
    
    private init() {}
    
    func fetchAlbumsData(completion: @escaping (_ albums: [Album])->()) {
        guard let url = URL(string: API) else { return }
        let mainGroup = DispatchGroup()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "error")
                return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDict = json as? [String : Any] else { return  print("error with getting  album json")}
                guard let results = jsonDict["results"] as? Array<Any> else { return print("error with cast json as array")}
                mainGroup.enter()
                guard let albums = self.getAlbumArrayByJSON(results: results) else { mainGroup.leave()
                    return
                }
                mainGroup.leave()
                
                mainGroup.notify(queue: .main) {
                    completion(albums)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchSongsData(by albumID: Int, completion: @escaping ([Song]?)->()) {
        guard let url = getSongListQueryURL(albumID: albumID) else { return print("bad request")}
        let mainGroup = DispatchGroup()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return print(error?.localizedDescription ?? "error with getting songs") }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDict = json as? [String: Any] else { return print("error with parse song JSON") }
                guard  let results = jsonDict["results"] as? Array<Any> else { return }
                mainGroup.enter()
                guard let songs = self.getSongArrayByJSON(results: results) else { return mainGroup.leave()}
                mainGroup.leave()
                
                mainGroup.notify(queue: .main) {
                    completion(songs)
                }
                
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func getSongListQueryURL(albumID: Int) -> URL? {
        let albumIDString = String(albumID)
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/lookup"
        components.queryItems = [
            URLQueryItem(name: "id", value: albumIDString),
            URLQueryItem(name: "entity", value: "song")
        ]
        guard let url = components.url else { return nil}
        return url
    }
    
    private func getAlbumArrayByJSON(results: Array<Any>) -> [Album]? {
        var albums: [Album] = []
        results.forEach { album in
            guard let album = album as? [String: Any] else { return }
            let albumObject = Album(by: album)
            albums.append(albumObject)
        }
        return albums
    }
    
    private func getSongArrayByJSON(results: Array<Any>) -> [Song]? {
        var songs: [Song] = []
        results.forEach { song in
            guard let song = song as? [String: Any] else { return }
            let songObject = Song(by: song)
            songs.append(songObject)
        }
        return songs
    }
}
