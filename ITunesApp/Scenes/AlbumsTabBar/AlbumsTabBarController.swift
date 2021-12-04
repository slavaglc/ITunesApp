//
//  AlbumsTabBarController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 30.11.2021.
//

import UIKit


final class AlbumsTabBarController: UITabBarController {
//  MARK - ViewControllers
    var albumListVC: AlbumListViewController?
    var historyAlbumsVC: HistoryAlbumsViewController?
//  MARK: - UI Elements
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.tintColor = .white
        bar.searchTextField.delegate = self
        bar.searchTextField.textColor = .white
        bar.searchTextField.addTarget(albumListVC, action: #selector(albumListVC?.searchBarEdited(sender:)), for: .editingChanged)
        bar.searchTextField.backgroundColor = #colorLiteral(red: 0.7356632352, green: 0.1479174197, blue: 0.05585322529, alpha: 1)
        bar.isHidden = true
        bar.placeholder = "Search album"
        bar.layer.cornerRadius = 10
        return bar
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        let searchImage = UIImage(systemName: "magnifyingglass")
        button.tintColor = .white
        button.setImage(searchImage, for: .normal)
        button.addTarget(self, action: #selector(showSearchButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumsTabBarConfigurator.shared.configure(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }
    
//  MARK: - Setup UI settings
    
    private func setupLayout() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        setupNavigationBar(for: navigationBar)
        addSearchButton()
        addSearchbar(for: navigationBar)
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
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = searchBarItem
    
    }
    
    private func addSearchButton() {
        let searchButtonItem = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = searchButtonItem
    }
    
//    MARK: - Actions
    
    @objc private func showSearchButtonPressed(sender: UIButton) {
        switch sender.tag {
        case 0: //search
            searchBar.fadeIn() { [weak self] in
                self?.searchBar.searchTextField.becomeFirstResponder()
            }
            selectedViewController = !albumListIsCurrentVC() ? albumListVC : selectedViewController
            sender.setImage(UIImage(systemName: "xmark"), for: .normal)
            sender.tag = 1
            break
        default: //cancel
            sender.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            searchBar.fadeOut { [weak self] in
                self?.searchBar.endEditing(true)
            }
            sender.tag = 0
            break
        }
    }
    
    private func albumListIsCurrentVC() -> Bool {
        selectedViewController == albumListVC
    }
}

// MARK: - TextField functions
extension AlbumsTabBarController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
