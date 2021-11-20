//
//  AlbumDetailsInteractor.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



protocol AlbumDetailsBusinessLogic {
    func fetchAlbumData()
    func fetchSongList()
}

protocol AlbumDetailsDataStore {
    var album: Album? { get set }
}

final class AlbumDetailsInteractor: AlbumDetailsDataStore, AlbumDetailsBusinessLogic  {
    
    
    var presenter: AlbumDetailsPresentingLogic?
    var album: Album?
    
    func fetchAlbumData() {
        guard let album = album else { return }
        let response = AlbumDetails.PresentingAlbum.Response.init(album: album)
        presenter?.presentAlbumInfo(response: response)
    }
    

    func fetchSongList() {
        guard let album = album else { return }
        NetworkManager.shared.fetchSongsData(by: album.albumID) { [weak self] songs in
            let response = AlbumDetails.PresentingSongs.Response.init(songs: songs)
            self?.presenter?.presentSongList(response: response)
        }
    }
    
   
}



