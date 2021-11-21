//
//  AlbumsViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import UIKit


protocol AlbumListDisplayLogic {
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel)
}

final class AlbumListViewController: UICollectionViewController {
    var interactor: AlbumListBusinessLogic?
    var router: AlbumListRoutingLogic?
    private var items: [AlbumCellIdentifiable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        AlbumListConfigurator.shared.configure(with: self)
        getAlbums()
    }
    

    private func setupNavigationBar() {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func getAlbums() {
        interactor?.fetchAlbums()
    }
}

extension AlbumListViewController: AlbumListDisplayLogic {
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel) {
        items = viewModel.items
        collectionView.reloadData()
        
    }
}

extension AlbumListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToAlbumDetails()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension AlbumListViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 3.2 , height: UIScreen.main.bounds.width / 3.2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

