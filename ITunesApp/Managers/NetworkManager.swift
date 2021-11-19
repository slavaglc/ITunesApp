//
//  NetworkManager.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation


public final class NetworkManager {
    
    static let shared = NetworkManager()
    let API =  "https://itunes.apple.com/search?term=billy+talent&entity=album"
    
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
                guard let jsonDict = json as? [String : Any] else { return  print("error with getting json")}
                guard let results = jsonDict["results"] as? Array<Any> else { return print("error with cast json as array")}
                mainGroup.enter()
                guard let albums = self.getModelByJSON(results: results) else { mainGroup.leave()
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
    
    private func getModelByJSON(results: Array<Any>) -> [Album]? {
        var albums: [Album] = []
        results.forEach { album in
            guard let album = album as? [String: Any] else { return }
            let albumObject = Album(by: album)
            albums.append(albumObject)
        }
        return albums
    }
}
