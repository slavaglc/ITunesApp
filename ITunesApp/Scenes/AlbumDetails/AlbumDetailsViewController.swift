//
//  AlbumDetailsViewController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//
import UIKit

protocol AlbumDetailsDisplayLogic {
    
}


final class AlbumDetailsViewController: UIViewController, AlbumDetailsDisplayLogic {
    var router: (NSObject & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    var interactor: AlbumDetailsBusinessLogic?
    
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
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        let imageView = createImageView()
        let label = createLabel()
        let button = createButton()
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(button)
        setupSequentialConstraints(for: [imageView, label, button])
    }
    
    
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "AlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfoAlbumInfo"
        
        return label
    }
    
    private func createButton() -> UIButton {
        let positionX = view.frame.midX
        let positionY = view.frame.minY
        let width = view.bounds.width
        let height = width
        let frame = CGRect(x: positionX, y: positionY, width: width, height: height)
        let button = UIButton(frame: frame)
        button.setTitle("Show song list", for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }
    
    private func setupSequentialConstraints(for views: [UIView]) {
        let padding = 20.0
        for (number, currentView) in views.enumerated() {


            switch number {
            case 0:
                setupFirstConstarint()
            default:
                setupOtherConstraints()
            }

            func setupFirstConstarint() {
                currentView.translatesAutoresizingMaskIntoConstraints = false
                let verticalConstraint = currentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
                let widthConstraint = currentView.widthAnchor.constraint(equalToConstant: view.bounds.width)
                let heightConstraint = currentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
                
                let centerConstraint = currentView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                let leadingConstraint = currentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: padding)
                let trailingConstraint = currentView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: padding)

                NSLayoutConstraint.activate([verticalConstraint, widthConstraint, heightConstraint, centerConstraint, leadingConstraint, trailingConstraint])
            }

            func setupOtherConstraints() {
                currentView.translatesAutoresizingMaskIntoConstraints = false
                let previousView = views[number - 1]
                let verticalConstraint = currentView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: padding)
                let leadingConstraint = currentView.leadingAnchor.constraint(equalTo: previousView.leadingAnchor)
                let trailingConstraints = currentView.trailingAnchor.constraint(equalTo: previousView.trailingAnchor)

                NSLayoutConstraint.activate([verticalConstraint, trailingConstraints, leadingConstraint])
            }
        }
    }
        
    private func setup() {
        AlbumDetailsConfigurator.shared.configure(with: self)
    }
    
    
}
