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
    private var items: [CellIdentifiable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        AlbumListConfigurator.shared.configure(with: self)
    }
    
    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    
}

extension AlbumListViewController: AlbumListDisplayLogic {
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel) {
        items = viewModel.items
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension AlbumListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
}
