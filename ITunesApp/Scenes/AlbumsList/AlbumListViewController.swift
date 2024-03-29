//
//  AlbumsViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import UIKit


protocol AlbumListDisplayLogic {
    var activityIndicator: UIActivityIndicatorView { get set }
    var searchBegins: Bool { get set }
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel)
    func reloadData()
    func displaySearchText(text: String)
}

final class AlbumListViewController: UICollectionViewController {
//  MARK: - Entities
    var interactor: AlbumListBusinessLogic?
    var router: (AlbumListRoutingLogic & AlbumListDataPassing)?
//  MARK: - Cells
    private var items: [AlbumCellIdentifiable] = []
    // MARK: - State properties
    var searchBegins: Bool = false
//  MARK: - UI Elements
    var activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var searchBar: UISearchBar = { () -> UISearchBar in
        let searchBar = tabBarController?.navigationItem.leftBarButtonItem?.customView as? UISearchBar
        return searchBar ?? UISearchBar()
    }()
//  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumListConfigurator.shared.configure(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }/Users/slava/Documents/Projects/Fanfic/Fanfic/Fonts
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.fetchAlbums(for: .random, loading: .primary)
    }
    
//  MARK: - Set parameters for UI Elements
    private func setupLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .onDrag
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3.2 , height: UIScreen.main.bounds.width / 3.2 )
        collectionView.collectionViewLayout = layout
        
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
//  MARK: - Actions
    @objc func searchBarEdited(sender: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(runSearchRequest), object: nil)
        perform(#selector(runSearchRequest), with: nil, afterDelay: 0.5)
    }
    
    @objc private func runSearchRequest() {
        guard let searchText = searchBar.text else {
            getAlbums(for: .random)
            return
        }
        getAlbums(for: .searchingFor(searchText))
    }
    
    private func getAlbums(for searchType: SearchingType = SearchingType.random) {
        interactor?.fetchAlbums(for: searchType, loading: .regular)
    }
}

//  MARK: - DisplayLogic
extension AlbumListViewController: AlbumListDisplayLogic {
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel) {
        items = viewModel.items
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func displaySearchText(text: String) {
        searchBar.text = text
    }
}
//  MARK: - CollectionView Functions
extension AlbumListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchBegins ? 0 : items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToAlbumDetails()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


