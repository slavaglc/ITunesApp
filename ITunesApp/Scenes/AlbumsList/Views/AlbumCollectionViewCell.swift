//
//  AlbumCollectionViewCell.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 13.11.2021.
//

import UIKit


protocol CellModelRepresentable {
    var viewModel: CellIdentifiable? {get set}
}

final class AlbumCollectionViewCell: UICollectionViewCell, CellModelRepresentable {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let artistLabel = UILabel()
    
    var viewModel: CellIdentifiable? {
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
        nameLabel.frame.size.width = self.contentView.frame.width
        artistLabel.frame.size.width = self.contentView.frame.width
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if viewModel != nil {
            viewModel = nil
        }
    }
    
    private func initialize() {
        backgroundColor = .yellow
        
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(artistLabel)
    }
    
    
    private func updateView() {
        guard let viewModel = viewModel as? AlbumCellViewModel else { return }
        nameLabel.text = viewModel.name
        artistLabel.text = viewModel.artist
    }
    
}
