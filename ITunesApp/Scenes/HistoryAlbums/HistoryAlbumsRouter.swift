//
//  HistoryAlbumsRouter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import Foundation


protocol HistoryAlbumsRoutingLogic {
    func routeToAlbumList()
}

protocol HistoryAlbumsDataPassing {
    var dataStore: HistoryAlbumsDataStore? { get }
}

final class HistoryAlbumsRouter  {
    weak var viewController: HistoryAlbumsViewController?
    var dataStore: HistoryAlbumsDataStore?
}

extension HistoryAlbumsRouter: HistoryAlbumsRoutingLogic, HistoryAlbumsDataPassing {
    
    func routeToAlbumList() {
        guard let viewController = viewController else { return }
        guard let destinationVC = getAlbumListVC() else { return }
        guard let sourceDS = dataStore else { return }
        guard var destinationDS = destinationVC.router?.dataStore else { return }
    

        navigateToAlbumList(source: viewController, destination: destinationVC)
        passDataToAlbumList(source: sourceDS, destination: &destinationDS)
        
    }
    
    private func navigateToAlbumList(source: HistoryAlbumsViewController, destination: AlbumListViewController) {
        guard let tabBarController = viewController?.tabBarController else { return }
        tabBarController.selectedViewController = destination
    }
    
    private func passDataToAlbumList(source: HistoryAlbumsDataStore, destination: inout AlbumListDataStore) {
        guard let selectedIndex = viewController?.tableView.indexPathForSelectedRow?.last else { return }
        destination.searchText = source.searchRequests[selectedIndex]
    }
    
    private func getAlbumListVC() -> AlbumListViewController? {
        guard let viewController = viewController else { return nil }
        var albumListVC: AlbumListViewController?
        viewController.tabBarController?.viewControllers?.forEach { vc in
            if vc is AlbumListViewController {
                albumListVC = vc as? AlbumListViewController
            }
        }
        return albumListVC
    }
    
    
}
