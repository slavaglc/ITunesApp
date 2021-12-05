//
//  AlbumDetailsView.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 04.12.2021.
//

import UIKit


final class AlbumDetailsView: UIView {
    
    //    MARK: - UIElements
    weak var viewController: AlbumDetailsViewController?

    lazy var songListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isHidden = true
        return tableView } ()
    
    private lazy var albumInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.setTitle(showButtonType.rawValue, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7630645037, green: 0.1636582017, blue: 0.05129658431, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(showButtonTouchUp(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(showButtonTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(showButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
   private lazy var albumInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var albumImageView: AdvancedImageView = {
        AdvancedImageView()
    }()
    
    private lazy var activityIdicator: UIActivityIndicatorView = {
        UIActivityIndicatorView(style: .large)
    }()
    
    
//  MARK: - Cells
    private var rows: [SongCellIdentifiable] = []
//  MARK: - State properties
    var songsLoaded: Bool = false
    private var showButtonType = ShowButtonType.showSongList
        
//  MARK: - Lifecycle
    public convenience init(for viewController: AlbumDetailsViewController) {
        self.init()
        self.viewController = viewController
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
//  MARK: - Model Configure
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

//  MARK: - Settings for UI elements
    private func setupLayout() {
        backgroundColor = .white
        
        albumInfoStackView.addArrangedSubview(albumImageView)
        albumInfoStackView.addArrangedSubview(albumInfoLabel)
        albumInfoStackView.addArrangedSubview(songListTableView)
        albumInfoStackView.addArrangedSubview(showButton)
        
        addSubview(albumInfoStackView)
        
        setConstraints(for: albumInfoStackView)
        setButtonParameters(button: showButton)
        setLabelParameters(label: albumInfoLabel)
        setImageViewParameters(imageView: albumImageView)
        setTableViewParameters(tableView: songListTableView)
        setActivityIndicatorParameters(activityIndicator: activityIdicator)
        
        songListTableView.addSubview(activityIdicator)
    }
    
    private func setTableViewParameters(tableView: UITableView) {
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
        imageView.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    
    private func setActivityIndicatorParameters(activityIndicator: UIActivityIndicatorView) {
        let navigationBarHeight = viewController?.navigationController?.navigationBar.frame.height
        let positionY = UIScreen.main.bounds.midY - (navigationBarHeight ?? 44) - showButton.bounds.height
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.midX, y: positionY)
        activityIndicator.color = .black
    }
    
    private func setLabelParameters(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        label.widthAnchor.constraint(equalTo: albumInfoStackView.widthAnchor ).isActive = true
    }
    
    private func setButtonParameters(button: UIButton) {
        button.heightAnchor.constraint(equalToConstant: frame.width / 7).isActive = true
        button.widthAnchor.constraint(equalTo: albumInfoStackView.widthAnchor).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
//  MARK: - Actions
    
    public func showLoadingCondition() {
        activityIdicator.startAnimating()
    }
    
    public func showStopLoadingCondition() {
        activityIdicator.stopAnimating()
        songsLoaded = true
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

//  MARK: - TableView Functions
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
