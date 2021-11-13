//
//  AlbumsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import Foundation


protocol AlbumListPresentationLogic {
    func presentAlbums()
}

class AlbumListPresenter {
    var viewController: AlbumListDisplayLogic?
}

extension AlbumListPresenter: AlbumListPresentationLogic {
    func presentAlbums() {
        
    }
    
}
