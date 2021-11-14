//
//  AlbumsConfigurator.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//




class AlbumListConfigurator {

    static let shared = AlbumListConfigurator()
    
    private init() {}
    
    func configure(with viewController: AlbumListViewController) {
        let viewController = viewController
        let interactor = AlbumListInteractor()
        let presenter = AlbumListPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        viewController.collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.nameOfClass)
    }
    
}
