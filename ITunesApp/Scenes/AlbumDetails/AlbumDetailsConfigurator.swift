//
//  AlbumDetailsConfigurator.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



final class AlbumDetailsConfigurator {
    
    static let shared = AlbumDetailsConfigurator()
    
    private init() {}
    
    public func configure(with viewController: AlbumDetailsViewController) {
        let interactor = AlbumDetailsInteractor()
        let presenter = AlbumDetailsPresenter()
        let router = AlbumDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor  
    }
    
    public func configureTableView(with view: AlbumDetailsView) {
        view.songListTableView.delegate = view
        view.songListTableView.dataSource = view
        view.songListTableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.nameOfClass)
    }
    
}
