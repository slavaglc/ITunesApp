//
//  AlbumsInteractor.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import Foundation


protocol AlbumListBusinessLogic {
    func fetchAlbums()
}

protocol AlbumListDataStore {
    var albums: [Album] { get }
}

final class AlbumListInteractor: AlbumListDataStore {
    var presenter: AlbumListPresentationLogic?
    var albums: [Album] = []
}

extension AlbumListInteractor: AlbumListBusinessLogic {
    func fetchAlbums() {
        NetworkManager.shared.fetchAlbumsData { albums in
            self.albums = albums
            let response = AlbumList.PresentingAlbums.Response(albums: albums)
            self.presenter?.presentAlbums(response: response)
        }
    }
}
