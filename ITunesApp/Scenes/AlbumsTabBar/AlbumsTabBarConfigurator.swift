//
//  AlbumsTabBarConfigurator.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 30.11.2021.
//

import UIKit


final class AlbumsTabBarConfigurator {
    static let shared = AlbumsTabBarConfigurator()
    
    private init() {}
    
    func configure(with viewController: AlbumsTabBarController) {
        
        viewController.tabBar.barTintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        viewController.tabBar.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        viewController.tabBar.tintColor = .white
        let albumListVC = AlbumListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let historyAlbumsVC = HistoryAlbumsViewController()
        
        albumListVC.title = "Search"
        historyAlbumsVC.title = "History"
        
        viewController.setViewControllers([albumListVC, historyAlbumsVC], animated: false)
    }
}
