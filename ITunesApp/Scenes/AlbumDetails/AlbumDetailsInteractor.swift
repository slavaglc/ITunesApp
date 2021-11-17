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
        presenter?.showAlbumID(album: album!)
    }
    
    func fetchSongList() {
         
    }
    
   
}



