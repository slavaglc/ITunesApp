//
//  AlbumCollectionViewCell.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import UIKit


protocol CellModelRepresentable {
    var viewModel: AlbumCellIdentifiable? {get set}
}

final class AlbumCollectionViewCell: UICollectionViewCell, CellModelRepresentable {
    
    var viewModel: AlbumCellIdentifiable? {
        didSet{
            updateView()
        }
    }
//    MARK: - UI Elements
    private lazy var imageView: AdvancedImageView = {
        AdvancedImageView()
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .black
            .withAlphaComponent(0.5)
        label.textColor = .white
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Arial-BoldMT", size: 11)
        label.backgroundColor = .lightGray
            .withAlphaComponent(0.7)
        label.textAlignment = .center
        return label
    }()
    
    
//    MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.contentView.frame
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if viewModel != nil {
            viewModel = nil
            imageView.image = nil
            nameLabel.text?.removeAll()
            artistLabel.text?.removeAll()
        }
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        setupNameLabelLayout()
        setupArtitsNameLayout()
    }
    
//    MARK: - Setup UI parameters
    
    private func initialize() {
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(artistLabel)
    }
    
    
    private func setupNameLabelLayout() {
        let labelWidth = self.contentView.frame.width
        let labelHeight = nameLabel.font.lineHeight * 1.5
        let labelPositionX = self.contentView.bounds.minX
        let labelPositionY = self.contentView.bounds.maxY - nameLabel.frame.height
        nameLabel.frame = CGRect(x: labelPositionX, y: labelPositionY, width: labelWidth, height: labelHeight)

    }
    
    private func setupArtitsNameLayout() {
        let labelWidth = self.contentView.frame.width
        let labelHeight = artistLabel.font.lineHeight
        let labelPositionX = self.contentView.bounds.minX
        let labelPositionY = self.contentView.bounds.minY
        artistLabel.frame = CGRect(x: labelPositionX, y: labelPositionY, width: labelWidth, height: labelHeight)
    }
//  MARK: - Setup values
    
    private func updateView() {
        guard let viewModel = viewModel as? AlbumCellViewModel else { return }
        nameLabel.text = viewModel.name
        artistLabel.text = viewModel.artist
        guard let imageURL = viewModel.imageURL else { return }
        imageView.setImage(by: imageURL, forKey: viewModel.lowResolutionImageKey)
    }
}
