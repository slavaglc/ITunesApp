//
//  AlbumListRouter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



protocol AlbumListRoutingLogic {
    func routeToAlbumDetails()
}

protocol AlbumListDataPassing {
    var dataStore: AlbumListDataStore? { get }
}

final class AlbumListRouter: AlbumListRoutingLogic, AlbumListDataPassing {
    var dataStore: AlbumListDataStore?
    
    weak var viewController: AlbumListViewController?
    
    func routeToAlbumDetails() {
        let albumDetailsVC = AlbumDetailsViewController()
        guard let viewController = viewController else { return }
        guard let destinationRouter = albumDetailsVC.router else { return }
        guard var destinationDC = destinationRouter.dataStore else { return }
        guard let dataStore = dataStore else { return }
        passDataStoreToAlbumDetailsVC(source: dataStore, destination: &destinationDC)
        navigateToAlbumDetails(source: viewController, destination: albumDetailsVC)
    }
    
    private func navigateToAlbumDetails(source: AlbumListViewController, destination: AlbumDetailsViewController) {
        source.show(destination, sender: nil)
    }
    
    private func passDataStoreToAlbumDetailsVC(source: AlbumListDataStore, destination: inout AlbumDetailsDataStore) {
        guard let selectedIndex = viewController?.collectionView.indexPathsForSelectedItems?.first  else { return }
        destination.album = source.albums[selectedIndex.item]
    }
}
