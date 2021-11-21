//
//  AlbumListModels.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation

protocol AlbumCellIdentifiable {
    var identifier: String { get }
}

typealias AlbumCellViewModel = AlbumList.PresentingAlbums.ViewModel.AlbumCellViewModel

enum AlbumList {
    
    enum PresentingAlbums {
        struct Response {
            let albums: [Album]
        }
        
        struct ViewModel {
            struct AlbumCellViewModel: AlbumCellIdentifiable {
                var name: String
                var artist: String
                var imageURL: URL?
                var albumID: Int
                var lowResolutionImageKey: Int
                
                var identifier: String {
                    AlbumCollectionViewCell.nameOfClass
                }
                
                init(album: Album) {
                    name = album.name ?? "Unknow album"
                    artist = album.artist ?? "Unknow artist"
                    imageURL = album.imageURL
                    albumID = album.albumID
                    lowResolutionImageKey = albumID + 100
                }
            }
            let items: [AlbumCellViewModel]
        }
    }
}
