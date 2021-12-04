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
//    let songListTableView = UITableView()
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
        AlbumDetailsConfigurator.shared.configureTableView(with: view as! AlbumDetailsView)
    }
//    MARK: - Actions
//    @objc private func showButtonTapped(sender: UIButton) {
//        sender.backgroundColor = #colorLiteral(red: 0.7630645037, green: 0.1636582017, blue: 0.05129658431, alpha: 1)
//        sender.tintColor = .white
//
//        switch showButtonType {
//        case .showSongList:
//            sender.isEnabled = false
//            albumImageView.isHidden = true
//            albumInfoLabel.isHidden = true
//            songListTableView.fadeInFromLeftSide {
//                sender.isEnabled = true
//            }
//
//            if !songsLoaded {
//                getSongList()
//            }
//            showButtonType = .showAlbumInfo
//            showButton.setTitle(showButtonType.rawValue, for: .normal)
//
//        case .showAlbumInfo:
//            sender.isEnabled = false
//            songListTableView.isHidden = true
//            albumInfoLabel.fadeInFromRightSide()
//            albumImageView.fadeInFromRightSide {
//                sender.isEnabled = true
//            }
//            showButtonType = .showSongList
//            sender.setTitle(showButtonType.rawValue, for: .normal)
//        }
//    }
//
//    @objc private func showButtonTouchDown(sender: UIButton) {
//        sender.backgroundColor = #colorLiteral(red: 0.5443205237, green: 0.1194817498, blue: 0.04500549287, alpha: 1)
//        sender.tintColor = .lightGray
//    }
    
   func getSongList() {
        interactor?.fetchSongList()
    }
    
//    MARK: - Setting  parameters for UI elements
    
    private func setupLayout() {
        
        
//        view.backgroundColor = .white
//        setActivityIndicatorParameters(activityIndicator: activityIndicator)
//        songListTableView.addSubview(activityIndicator)
//        
//        let albumInfoStackView = createStackView()
//        setImageViewParameters(imageView: albumImageView)
//        setLabelParameters(label: albumInfoLabel)
//        setButtonParameters(button: showButton)
//        
//        albumInfoStackView.addArrangedSubview(albumImageView)
//        albumInfoStackView.addArrangedSubview(albumInfoLabel)
//        albumInfoStackView.addArrangedSubview(songListTableView)
//        albumInfoStackView.addArrangedSubview(showButton)
//        
//        view.addSubview(albumInfoStackView)
//        setTableViewParameters(tableView: songListTableView)
//        setConstraints(for: albumInfoStackView)
    }
    
//
//    private func setTableViewParameters(tableView: UITableView) {
//        tableView.isHidden = true
//        tableView.backgroundColor = .white
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2).isActive = true
//        tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//        tableView.separatorStyle = .none
//    }
//
//    private func setConstraints(for view: UIView) {
//        let padding = 10.0
//        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
//        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding).isActive = true
//        view.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
//        view.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, constant: -padding).isActive = true
//    }
//
//    private func setImageViewParameters(imageView: AdvancedImageView) {
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//    }
//
//    private func setActivityIndicatorParameters(activityIndicator: UIActivityIndicatorView) {
//        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? view.frame.height
//        let positionY = view.frame.midY - navigationBarHeight
//        activityIndicator.center = CGPoint(x: view.frame.midX, y: positionY)
//        activityIndicator.color = .black
//    }
//
//    private func setLabelParameters(label: UILabel) {
//        label.numberOfLines = 0
//        label.text = "AlbumInfo"
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.heightAnchor.constraint(equalToConstant: self.view.frame.width / 3).isActive = true
//        label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//    }
//
//    private func setButtonParameters(button: UIButton) {
//        button.setTitle(showButtonType.rawValue, for: .normal)
//        button.backgroundColor = #colorLiteral(red: 0.7630645037, green: 0.1636582017, blue: 0.05129658431, alpha: 1)
//        button.tintColor = .white
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = true
//
//        button.heightAnchor.constraint(equalToConstant: self.view.frame.width / 7).isActive = true
//        button.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
//        button.translatesAutoresizingMaskIntoConstraints = false
////        button.addTarget(self, action: #selector(showButtonTapped(sender:)), for: .touchUpInside)
////        button.addTarget(self, action: #selector(showButtonTouchDown(sender:)), for: .touchDown)
//    }
//
//    private func createStackView() -> UIStackView {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }
    
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
