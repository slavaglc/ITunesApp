//
//  AlbumDetailsView.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 04.12.2021.
//

import UIKit


final class AlbumDetailsView: UIView {
    
    weak var viewController: AlbumDetailsViewController?
    
    lazy var songListTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView }()
    
    lazy var albumInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let albumInfoLabel = UILabel()
    private let albumImageView = AdvancedImageView()
    private let showButton = UIButton()
    private var rows: [SongCellIdentifiable] = []
    var songsLoaded: Bool = false
    private var showButtonType = ShowButtonType.showSongList
        
    public convenience init(for viewController: AlbumDetailsViewController) {
        self.init()
        self.viewController = viewController
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    
    public func configure(with viewModel: AlbumDetailsViewModel) {
        albumInfoLabel.text = viewModel.description
        guard let imageURL = viewModel.albumViewModel.imageURLHighResolution else { return }
        albumImageView.setImage(by: imageURL, forKey: viewModel.albumViewModel.highResolutionImageKey)
    }
    
    public func configure(with viewModel: SongsViewModel) {
        rows = viewModel.rows
        songsLoaded = true
        songListTableView.reloadData()
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        albumInfoStackView.addArrangedSubview(albumImageView)
        albumInfoStackView.addArrangedSubview(albumInfoLabel)
        albumInfoStackView.addArrangedSubview(songListTableView)
        albumInfoStackView.addArrangedSubview(showButton)
        setTableViewParameters(tableView: songListTableView)
        
        addSubview(albumInfoStackView)
        setConstraints(for: albumInfoStackView)
        setButtonParameters(button: showButton)
        setLabelParameters(label: albumInfoLabel)
        setImageViewParameters(imageView: albumImageView)
    }
    
    
    private func setTableViewParameters(tableView: UITableView) {
        
        songListTableView.backgroundColor = .white
        songListTableView.translatesAutoresizingMaskIntoConstraints = false
        songListTableView.widthAnchor.constraint(equalTo: albumInfoStackView.widthAnchor).isActive = true
        songListTableView.separatorStyle = .none
    }
    
    private func setConstraints(for view: UIView) {
        let padding = 10.0
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        view.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: -padding).isActive = true
    }
    
    private func setImageViewParameters(imageView: AdvancedImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: albumInfoStackView.widthAnchor).isActive = true
    }
    
    
//    private func setActivityIndicatorParameters(activityIndicator: UIActivityIndicatorView) {
//        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? view.frame.height
//        let positionY = view.frame.midY - navigationBarHeight
//        activityIndicator.center = CGPoint(x: view.frame.midX, y: positionY)
//        activityIndicator.color = .black
//    }
    
    private func setLabelParameters(label: UILabel) {
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        label.widthAnchor.constraint(equalTo: albumInfoStackView.widthAnchor ).isActive = true
    }
    
    private func setButtonParameters(button: UIButton) {
        button.setTitle(showButtonType.rawValue, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7630645037, green: 0.1636582017, blue: 0.05129658431, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        button.heightAnchor.constraint(equalToConstant: frame.width / 7).isActive = true
        
        button.widthAnchor.constraint(equalTo: albumInfoStackView.widthAnchor).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showButtonTouchUp(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(showButtonTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(showButtonTapped(sender:)), for: .touchUpInside)
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    @objc private func showButtonTapped(sender: UIButton) {
            sender.backgroundColor = #colorLiteral(red: 0.7630645037, green: 0.1636582017, blue: 0.05129658431, alpha: 1)
            sender.tintColor = .white
            switch showButtonType {
            case .showSongList:
                sender.isEnabled.toggle()
                albumImageView.isHidden.toggle()
                albumInfoLabel.isHidden.toggle()
                songListTableView.fadeInFromLeftSide {
                    sender.isEnabled.toggle()
                }
    
                if !songsLoaded {
                    guard let viewController = viewController else { return }
                    viewController.getSongList()
                }
                showButtonType = .showAlbumInfo
                showButton.setTitle(showButtonType.rawValue, for: .normal)
    
            case .showAlbumInfo:
                sender.isEnabled = false
                songListTableView.isHidden = true
                albumInfoLabel.fadeInFromRightSide()
                albumImageView.fadeInFromRightSide {
                    sender.isEnabled = true
                }
                showButtonType = .showSongList
                sender.setTitle(showButtonType.rawValue, for: .normal)
            }
        }
    
    @objc private func showButtonTouchDown(sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.5443205237, green: 0.1194817498, blue: 0.04500549287, alpha: 1)
        sender.tintColor = .lightGray
    }
    
    @objc private func showButtonTouchUp(sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.7630645037, green: 0.1636582017, blue: 0.05129658431, alpha: 1)
        sender.tintColor = .white
    }
    
}

extension AlbumDetailsView: UITableViewDataSource, UITableViewDelegate {
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
