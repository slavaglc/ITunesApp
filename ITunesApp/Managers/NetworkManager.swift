//
//  NetworkManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation
import UIKit


public final class NetworkManager {
    
    static let shared = NetworkManager()
    private let host = "itunes.apple.com"
    private let limitOfAlbums = 200
    
    private var albumFetchingDataTasks: [URLSessionDataTask] = []
    
    private init() {}
    
   func fetchAlbumsData(for searchType: SearchingType, completion: @escaping (_ albums: [Album])->())  {
 
        guard let url = getSearchQueryURL(for: searchType) else { return }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let dataTask = getDataTaskForFetchingAlbums(with: url, for: session, completion: completion)
        albumFetchingDataTasks.append(dataTask)
        
        for (requestNumber, task) in albumFetchingDataTasks.enumerated() {
            if requestNumber == albumFetchingDataTasks.count - 1 {
                task.resume()
            } else {
                task.cancel()
            }
        }
    }
    
   func fetchSongsData(by albumID: Int, completion: @escaping ([Song])->()) {
        guard let url = getSongListQueryURL(albumID: albumID) else { return print("bad request")}
        
        let mainGroup = DispatchGroup()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return print(error?.localizedDescription ?? "error with getting songs") }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDict = json as? [String: Any] else { return print("error with parse song JSON") }
                
                guard  let results = jsonDict["results"] as? Array<Any> else { return }
                mainGroup.enter()
                guard let songs = self.getSongArrayByJSON(results: results) else {
                    
                    return }
                
                mainGroup.leave()
                
                mainGroup.notify(queue: .main) {
                    completion(songs)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func getSearchQueryURL(for searchType: SearchingType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/search"
        
        switch searchType {
        case .random:
            components.queryItems = [
                URLQueryItem(name: "term", value: getRandomChar())
            ]
        case .searchingFor(let searchText):
            let searchText = getFormattedQueryString(string: searchText)
            components.queryItems = [
                URLQueryItem(name: "term", value: searchText)
            ]
        }
        components.queryItems?.append(URLQueryItem(name: "entity", value: "album"))
        components.queryItems?.append(URLQueryItem(name: "limit", value: "\(limitOfAlbums)"))
        return components.url
    }
    
    private func getDataTaskForFetchingAlbums(with url: URL, for session: URLSession, completion: @escaping (_ albums: [Album])->()) -> URLSessionDataTask {
     
        let mainGroup = DispatchGroup()
      let dataTask =  session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "error")
                return }
           
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDict = json as? [String : Any] else { return  print("error with getting  album json")}
                guard let results = jsonDict["results"] as? Array<Any> else { return print("error with cast json as array")}
                mainGroup.enter()
                guard let albums = self.getAlbumArrayByJSON(results: results) else { return }
                mainGroup.leave()
                
                mainGroup.notify(qos: .default, flags: .barrier, queue: .main) { [weak self] in
                    self?.albumFetchingDataTasks.removeAll()
                    completion(albums)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return dataTask
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
        for song in results {
            guard let song = song as? [String: Any] else { continue }
            guard let wrapperType = song["wrapperType"] as? String else { continue }
            guard wrapperType != "collection" else { continue }
            let songObject = Song(by: song)
            songs.append(songObject)
        }
        return songs
    }
    
    private func getFormattedQueryString(string: String) -> String {
        string.replacingOccurrences(of: " ", with: "+")
    }
        
    private func getRandomChar() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        guard let result = letters.randomElement() else { return "a" }
        let resultString = String(result)
        return resultString
    }
}
