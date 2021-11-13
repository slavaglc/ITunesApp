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

class AlbumListInteractor {
    var presenter: AlbumListPresentationLogic?
}

extension AlbumListInteractor: AlbumListBusinessLogic {
    func fetchAlbums() {
    }
    
}
