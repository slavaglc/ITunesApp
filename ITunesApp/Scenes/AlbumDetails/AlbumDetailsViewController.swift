//
//  AlbumDetailsViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//
import UIKit

protocol AlbumDetailsDisplayLogic {
    func displayAlbumInfo(viewModel: AlbumDetailsViewModel)
}


final class AlbumDetailsViewController: UIViewController {
   
//MARK: - Entities
    var router: (NSObject & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    var interactor: AlbumDetailsBusinessLogic?
//MARK: - UI Elements
    var albumInfoLabel: UILabel?
    var albumImageView: AdvancedImageView?
    lazy var songListTableView: UITableView = { () -> UITableView in
        let tableView = UITableView()
            tableView.backgroundColor = .blue
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2).isActive = true
            tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            return tableView
    }()
    
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
        setupLayout()
        interactor?.fetchAlbumData()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        albumImageView = createImageView()
        albumInfoLabel = createLabel()
        let albumInfoStackView = createStackView()
        
        guard let albumImageView = albumImageView else { return }
        guard let albumInfoLabel = albumInfoLabel else { return }
        let button = createButton()
        albumImageView.isHidden = true
        albumInfoLabel.isHidden = true
        albumInfoStackView.addArrangedSubview(albumImageView)
        albumInfoStackView.addArrangedSubview(albumInfoLabel)
        albumInfoStackView.addArrangedSubview(songListTableView)
        albumInfoStackView.addArrangedSubview(button)
        
        view.addSubview(albumInfoStackView)
        setConstraints(for: albumInfoStackView)
    }
    
    private func setConstraints(for view: UIView) {
        let padding = 10.0
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding).isActive = true
        view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.3).isActive = true
    }
    
    
//    MARK: - Creating UI Elements
    private func createImageView() -> AdvancedImageView {
        let imageView = AdvancedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        return imageView
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "AlbumInfo"
        label.backgroundColor = .gray
            .withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: self.view.frame.width / 3).isActive = true
        label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        return label
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Show song list", for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: self.view.frame.width / 7).isActive = true
        button.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        return button
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        return tableView
    }
    
//        MARK: - Configure Clean Swift pattern
    private func setup() {
        AlbumDetailsConfigurator.shared.configure(with: self)
    }
}


//      MARK: - Display Logic
extension AlbumDetailsViewController: AlbumDetailsDisplayLogic {
  
     func displayAlbumInfo(viewModel: AlbumDetailsViewModel) {
        albumInfoLabel?.text = viewModel.description
        
         guard let imageURL = viewModel.albumViewModel.imageURLHighResolution else { return }
         
         albumImageView?.setImage(by: imageURL, forKey: viewModel.albumViewModel.highResolutionImageKey)
    }
    
}
// MARK: - TableView functions
extension AlbumDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
