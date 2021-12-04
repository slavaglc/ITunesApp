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
}

final class AlbumListViewController: UICollectionViewController, UISearchBarDelegate {
    var interactor: AlbumListBusinessLogic?
    var router: (AlbumListRoutingLogic & AlbumListDataPassing)?
    private var items: [AlbumCellIdentifiable] = []
    
    // MARK: - State properties
    var searchBegins: Bool = false
    //    MARK: - UI Elements
    var activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var searchBar: UISearchBar = { () -> UISearchBar in
        let searchBar = tabBarController?.navigationItem.leftBarButtonItem?.customView as? UISearchBar
        return searchBar ?? UISearchBar()
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlbumListConfigurator.shared.configure(with: self)
        getAlbums()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
    
    
    //MARK: - Set parameters for UI Elements
    private func setupLayout() {
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .onDrag
    }
    
    //MARK: - Actions
   
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
        interactor?.fetchAlbums(for: searchType)
    }
}

//MARK: - DisplayLogic
extension AlbumListViewController: AlbumListDisplayLogic {
   
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel) {
        items = viewModel.items
        collectionView.reloadData()
        
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
// MARK: - CollectionView Functions

extension AlbumListViewController: UICollectionViewDelegateFlowLayout {
    
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
// MARK: - TextField functions
extension AlbumListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

