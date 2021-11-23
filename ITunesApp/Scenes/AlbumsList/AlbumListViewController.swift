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

final class AlbumListViewController: UICollectionViewController, UISearchBarDelegate {
    var interactor: AlbumListBusinessLogic?
    var router: AlbumListRoutingLogic?
    private var items: [AlbumCellIdentifiable] = []
    
    // MARK: - State properties
    private var searchBegings: Bool = false
    //    MARK: - UI Elements
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let searchBar = UISearchBar()
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
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        collectionView.backgroundColor = .white
        setupNavigationBar(for: navigationBar)
        addSearchbar(for: navigationBar)
        addSearchButton()
    }
    
    private func setupNavigationBar(for navigationBar: UINavigationBar) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        
    }
    
    
    private func addSearchbar(for navBar: UINavigationBar) {
        let frame = CGRect(x: navBar.bounds.midX, y: navBar.bounds.midY, width: navBar.frame.width / 1.3, height: navBar.frame.height)
        searchBar.frame = frame
        
        searchBar.tintColor = .white
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarEdited(sender:)), for: .editingChanged)
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.7356632352, green: 0.1479174197, blue: 0.05585322529, alpha: 1)
        searchBar.isHidden = true
        searchBar.placeholder = "Search album"
        searchBar.layer.cornerRadius = 10
        
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = searchBarItem
    }
    
    private func addSearchButton() {
        let searchButton = UIButton()
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.tintColor = .white
        searchButton.setImage(searchImage, for: .normal)
        let searchButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = searchButtonItem
        searchButton.addTarget(self, action: #selector(showSearchButtonPressed(sender:)), for: .touchUpInside)
    }
    
    //MARK: - Actions
   
    @objc private func searchBarEdited(sender: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(runSearchRequest), object: nil)
        perform(#selector(runSearchRequest), with: nil, afterDelay: 0.5)
    }
    
    @objc func runSearchRequest() {
        guard let searchText = searchBar.text else {
            getAlbums(for: .random)
            return
        }
        getAlbums(for: .searchingFor(searchText))
    }
    
    @objc private func showSearchButtonPressed(sender: UIButton) {
        guard let searchBar = navigationItem.leftBarButtonItem?.customView as? UISearchBar else { return }
        
        switch sender.tag {
        case 0: //search
            searchBar.fadeIn() {
                searchBar.searchTextField.becomeFirstResponder()
            }
            sender.setImage(UIImage(systemName: "xmark"), for: .normal)
            sender.tag = 1
            break
        default: //cancel
            sender.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            searchBar.fadeOut {
                searchBar.endEditing(true)
            }
            sender.tag = 0
            break
        }
    }
    
    
    private func getAlbums(for searchType: SearchingType = SearchingType.random) {
        activityIndicator.startAnimating()
        searchBegings = true
        collectionView.reloadData()
        interactor?.fetchAlbums(for: searchType)
    }
    
    
    
}

//MARK: - DisplayLogic
extension AlbumListViewController: AlbumListDisplayLogic {
    func showAlbums(viewModel: AlbumList.PresentingAlbums.ViewModel) {
        items = viewModel.items
        activityIndicator.stopAnimating()
        searchBegings = false
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
        searchBegings ? 0 : items.count
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

