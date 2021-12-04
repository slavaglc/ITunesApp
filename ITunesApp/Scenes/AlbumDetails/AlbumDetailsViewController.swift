//
//  AlbumDetailsViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//
import UIKit

protocol AlbumDetailsDisplayLogic {
    func displayAlbumInfo(viewModel: AlbumDetailsViewModel)
    func displaySongs(viewModel: SongsViewModel)
    func showStartLoadingCondition()
    func showStopLoadingCondition()
}

final class AlbumDetailsViewController: UIViewController {
   
//  MARK: - Entities
    var router: (NSObject & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    var interactor: AlbumDetailsBusinessLogic?
    
//  MARK: - State properties
    var songsLoaded: Bool = false
    
    private var showButtonType = ShowButtonType.showSongList
    
//  MARK: - UI Elements
    lazy var albumDetailsView: AlbumDetailsView = { AlbumDetailsView(for: self)
    }()
//   MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        interactor?.fetchAlbumData()
    }
    
    override func loadView() {
        view = albumDetailsView
        AlbumDetailsConfigurator.shared.configureTableView(with: albumDetailsView )
    }
//   MARK: - Actions
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
    
    func showStartLoadingCondition() {
        albumDetailsView.showLoadingCondition()
    }
    
    func showStopLoadingCondition() {
        albumDetailsView.showStopLoadingCondition()
    }
}
