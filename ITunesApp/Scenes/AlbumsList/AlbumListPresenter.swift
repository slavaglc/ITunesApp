//
//  AlbumsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import Foundation


protocol AlbumListPresentationLogic {
    func presentAlbums(response: AlbumList.PresentingAlbums.Response)
    func presentActivityIndicator()
}

final class AlbumListPresenter {
    var viewController: AlbumListDisplayLogic?
}

extension AlbumListPresenter: AlbumListPresentationLogic {
    
    func presentAlbums(response: AlbumList.PresentingAlbums.Response) {
        var items: [AlbumCellViewModel] = []
        
        response.albums.forEach { album in
            items.append(AlbumCellViewModel(album: album))
        }
                
        let viewModel = AlbumList.PresentingAlbums.ViewModel.init(items: items)
        viewController?.showAlbums(viewModel: viewModel)
    }
    
    func presentActivityIndicator() {
        viewController?.showActivityIndidcator()
    }
    
}
