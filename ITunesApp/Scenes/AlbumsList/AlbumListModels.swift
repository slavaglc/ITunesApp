//
//  AlbumListModels.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import Foundation

protocol CellIdentifiable {
    var identifier: String { get }
    var height: Double { get }
    var width: Double { get }
}

typealias AlbumCellViewModel = AlbumList.PresentingAlbums.ViewModel.AlbumCellViewModel

enum AlbumList {
    
    enum PresentingAlbums {
        struct Response {
            let albums: [Album]
        }
        
        struct ViewModel {
            struct AlbumCellViewModel: CellIdentifiable {
                var name: String
                var artist: String
                var imageURL: URL?
                
                var identifier: String {
                    AlbumCollectionViewCell.nameOfClass
                }
                
                var height: Double {
                    100
                }
                
                var width: Double {
                    100
                }
                
                init(album: Album) {
                    name = album.name ?? "Unknow album"
                    artist = album.artist ?? "Unknow artist"
                    imageURL = album.imageURL
                }
            }
            let items: [AlbumCellViewModel]
        }
    }
}
