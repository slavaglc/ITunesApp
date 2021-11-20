//
//  AlbumDetailsConfigurator.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



final class AlbumDetailsConfigurator {

    static let shared = AlbumDetailsConfigurator()
    
   public func configure(with viewController: AlbumDetailsViewController) {
       let interactor = AlbumDetailsInteractor()
       let presenter = AlbumDetailsPresenter()
       let router = AlbumDetailsRouter()
       viewController.interactor = interactor
       viewController.router = router
       viewController.songListTableView.delegate = viewController
       interactor.presenter = presenter
       presenter.viewController = viewController
       router.viewController = viewController
       router.dataStore = interactor
       
    }
    
}
