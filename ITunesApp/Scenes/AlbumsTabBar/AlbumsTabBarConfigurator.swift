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
        
        viewController.tabBar.barTintColor = #colorLiteral(red: 0.7356632352, green: 0.1479174197, blue: 0.05585322529, alpha: 1)
        let albumListVC = AlbumListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let secondVC = TemporaryVC()
        
        albumListVC.title = "Albums"
        secondVC.title = "Second VC"
        
        viewController.setViewControllers([albumListVC, secondVC], animated: false)
    }
}
