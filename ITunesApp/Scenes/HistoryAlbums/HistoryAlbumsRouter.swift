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



final class HistoryAlbumsRouter  {
    
    weak var viewController: HistoryAlbumsViewController?
    
}

extension HistoryAlbumsRouter: HistoryAlbumsRoutingLogic {
    func routeToAlbumList() {
        guard let viewController = viewController else { return }
        guard let destinationVC = getAlbumListVC() else { return }
        
        navigateToAlbumList(source: viewController, destination: destinationVC)
    }
    
    private func navigateToAlbumList(source: HistoryAlbumsViewController, destination: AlbumListViewController) {
        guard let tabBarController = viewController?.tabBarController else { return }
        tabBarController.selectedViewController = destination
    }
    
    private func getAlbumListVC() -> AlbumListViewController? {
        guard let viewController = viewController else { return nil }
        var albumListVC: AlbumListViewController?
        viewController.tabBarController?.viewControllers?.forEach{ vc in
            if vc is AlbumListViewController {
                albumListVC = vc as? AlbumListViewController
            }
        }
        return albumListVC
    }
}
