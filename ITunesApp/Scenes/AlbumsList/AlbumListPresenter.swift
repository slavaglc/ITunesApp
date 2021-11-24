//
//  AlbumsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import Foundation


protocol AlbumListPresentationLogic {
    func presentAlbums(response: AlbumList.PresentingAlbums.Response)
    func presentSearchCondition()
    func presentReloadingData()
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
        presentStopSearchCondition()
        viewController?.showAlbums(viewModel: viewModel)
    }
    
    func presentSearchCondition() {
        viewController?.activityIndicator.startAnimating()
        viewController?.searchBegins = true
        presentReloadingData()
    }
    
    func presentStopSearchCondition() {
        
        viewController?.activityIndicator.stopAnimating()
        viewController?.searchBegins = false
    }
    
    func presentReloadingData() {
        viewController?.reloadData()
    }
    
}
