//
//  HistoryAlbumsTableViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import UIKit


protocol HistoryAlbumsDisplayLogic {
    var activityIndicator: UIActivityIndicatorView { get set }
    func displaySearchRequests(viewModel: HistoryAlbums.PresentingHistory.ViewModel)
}

class HistoryAlbumsViewController: UITableViewController {
    var interactor: HistoryAlbumsBusinessLogic?
    var router: HistoryAlbumsRoutingLogic?
    private var rows: [HistoryCellIdentifiable] = []
//    MARK: - UI Elements
    var activityIndicator = UIActivityIndicatorView(style: .large)
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        HistoryAlbumsConfigurator.shared.configure(with: self)
        tableView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.fetchHistoryAlbums()
    }
}
// MARK: - Display logic
extension HistoryAlbumsViewController: HistoryAlbumsDisplayLogic {
    
    func displaySearchRequests(viewModel: HistoryAlbums.PresentingHistory.ViewModel) {
        rows = viewModel.rows
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension HistoryAlbumsViewController {
  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToAlbumList()
    }
}
