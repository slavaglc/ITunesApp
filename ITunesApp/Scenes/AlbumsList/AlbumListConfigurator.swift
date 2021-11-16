//
//  AlbumsConfigurator.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//




final class AlbumListConfigurator {

    static let shared = AlbumListConfigurator()
    
    private init() {}
    
    func configure(with viewController: AlbumListViewController) {
        let viewController = viewController
        let interactor = AlbumListInteractor()
        let presenter = AlbumListPresenter()
        let router = AlbumListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        router.viewController = viewController
        
        viewController.collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.nameOfClass)
    }
    
}
