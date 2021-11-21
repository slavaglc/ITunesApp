//
//  AlbumDetailsModels.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 17.11.2021.
//

import Foundation


protocol SongCellIdentifiable {
    var identifier: String { get }
    var height: Int { get }
}

typealias AlbumDetailsViewModel = AlbumDetails.PresentingAlbum.ViewModel
typealias SongsViewModel = AlbumDetails.PresentingSongs.ViewModel
typealias SongCellViewModel = AlbumDetails.PresentingSongs.ViewModel.SongCellViewModel

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
                let highResolutionImageKey: Int
                let name: String
                let artist: String
                let releaseDate: String
                let country: String
                let trackCount: Int
                let imageURL: URL?
                let imageURLHighResolution: URL?
                
                
                init(album: Album) {
                    albumID = album.albumID ?? 0
                    name = album.name ?? "Unknow album"
                    artist = album.artist ?? "Unknow artist"
                    releaseDate = album.releaseDate ?? "Unknow date"
                    country = album.country ?? "Unknow country"
                    trackCount = album.trackCount ?? 0
                    imageURL = album.imageURL
                    imageURLHighResolution = album.imageURLHighResolution
                    highResolutionImageKey = albumID + 600
                }
            }
            
        }
    }
    
    enum PresentingSongs {
        struct Response {
            let songs: [Song]
        }
        
        struct ViewModel {
            let rows: [SongCellViewModel]
            
            struct SongCellViewModel: SongCellIdentifiable {
                
                let trackName: String
                let trackMills: Int
                let minutes: Int
                let restOfSeconds: Int
                var identifier: String {
                    SongTableViewCell.nameOfClass
                }
                
                var height: Int {
                    55
                }
                
                
                init(song: Song) {
                    trackName = song.trackName ?? "Unknow track name"
                    trackMills = song.trackTimeMillis ?? 0
                    restOfSeconds = (trackMills / 1000) % 60
                    minutes = (trackMills / (1000 * 60)) % 60
                }
            }
        }
    }
}

enum ShowButtonType: String {
    case showSongList = "Show song list"
    case showAlbumInfo = "Show album info"
}
