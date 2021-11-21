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
    
    private let imageView = AdvancedImageView()
    private let nameLabel = UILabel()
    private let artistLabel = UILabel()
    
    var viewModel: AlbumCellIdentifiable? {
        didSet{
            updateView()
        }
    }
    
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
        }
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        setupNameLabelLayout()
        setupArtitsNameLayout()
    }
    
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
        nameLabel.textAlignment = .center
        
        nameLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        nameLabel.textColor = .white
    }
    
    private func setupArtitsNameLayout() {
        artistLabel.font = UIFont(name: "Arial-BoldMT", size: 11)
        
        let labelWidth = self.contentView.frame.width
        let labelHeight = artistLabel.font.lineHeight
        let labelPositionX = self.contentView.bounds.minX
        let labelPositionY = self.contentView.bounds.minY
        artistLabel.frame = CGRect(x: labelPositionX, y: labelPositionY, width: labelWidth, height: labelHeight)
        
        artistLabel.backgroundColor = .white
            .withAlphaComponent(0.7)
        artistLabel.textAlignment = .center
        
    }
    
    
    private func updateView() {
        guard let viewModel = viewModel as? AlbumCellViewModel else { return }
        nameLabel.text = viewModel.name
        artistLabel.text = viewModel.artist
        guard let imageURL = viewModel.imageURL else { return }
        
        imageView.setImage(by: imageURL, forKey: viewModel.lowResolutionImageKey)

    }
}
