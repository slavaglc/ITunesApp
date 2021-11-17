//
//  AlbumDetailsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



protocol AlbumDetailsPresentingLogic {
    func showAlbumID(album: Album)
}

class AlbumDetailsPresenter: AlbumDetailsPresentingLogic {
    
    var viewController: AlbumDetailsDisplayLogic?
    
    func showAlbumID(album: Album) {
        viewController?.displayAlbumID(album: album)
    }
}
