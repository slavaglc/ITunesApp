//
//  AlbumDetailsModels.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 17.11.2021.
//

import Foundation


typealias AlbumDetailsViewModel = AlbumDetails.PresentingAlbum.ViewModel

enum AlbumDetails {
    enum PresentingAlbum {
        struct Response {
            let album: Album
        }

        struct ViewModel {
            let description: String
            let albumViewModel: AlbumViewModel
            
            struct AlbumViewModel {
                let albumID: Int
                let name: String
                let artist: String
                let releaseDate: String
                let country: String
                let imageURL: URL?
                
                init(album: Album) {
                    albumID = album.albumID ?? 0
                    name = album.name ?? "Unknow album"
                    artist = album.artist ?? "Unknow artist"
                    releaseDate = album.releaseDate ?? "Unknow date"
                    country = album.country ?? "Unknow country"
                    imageURL = album.imageURL
                }
            }
            
        }
    }
    
    enum PresentingSongs {
        struct Response {
            
        }
    }
    
}
