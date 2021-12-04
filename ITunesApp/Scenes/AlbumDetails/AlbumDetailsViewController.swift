//
//  AlbumDetailsViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//
import UIKit

protocol AlbumDetailsDisplayLogic {
    var songsLoaded: Bool {get set}
    var activityIndicator: UIActivityIndicatorView { get set }
    func displayAlbumInfo(viewModel: AlbumDetailsViewModel)
    func displaySongs(viewModel: SongsViewModel)
}

final class AlbumDetailsViewController: UIViewController {
   
//MARK: - Entities
    var router: (NSObject & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    var interactor: AlbumDetailsBusinessLogic?
    
//MARK: - State properties
    var songsLoaded: Bool = false
    
    private var showButtonType = ShowButtonType.showSongList
    
//MARK: - UI Elements
    lazy var albumDetailsView: AlbumDetailsView = { AlbumDetailsView(for: self)
    }()
    var activityIndicator = UIActivityIndicatorView(style: .large)

    private var rows: [SongCellIdentifiable] = []
//    MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.fetchAlbumData()
    }
    
    override func loadView() {
        view = albumDetailsView
        AlbumDetailsConfigurator.shared.configureTableView(with: albumDetailsView )
    }
//    MARK: - Actions
   func getSongList() {
        interactor?.fetchSongList()
    }
    
//  MARK: - Configure Clean Swift pattern
    private func setup() {
        AlbumDetailsConfigurator.shared.configure(with: self)
    }
}

//  MARK: - Display Logic
extension AlbumDetailsViewController: AlbumDetailsDisplayLogic {
  
     func displayAlbumInfo(viewModel: AlbumDetailsViewModel) {
         guard let view = view as? AlbumDetailsView else { return }
         view.configure(with: viewModel)
    }
    
    func displaySongs(viewModel: SongsViewModel) {
        guard let view = view as? AlbumDetailsView else { return }
        view.configure(with: viewModel)
    }
}
// MARK: - TableView functions
extension AlbumDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = rows[indexPath.row]
        return CGFloat(cellViewModel.height)
    }
  
}
