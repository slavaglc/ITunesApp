//
//  SongTableViewCell.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 20.11.2021.
//

import UIKit


protocol SongTableViewCellRepresentable {
    var viewModel: SongCellIdentifiable? { get set }
}


final class SongTableViewCell: UITableViewCell, SongTableViewCellRepresentable {
    var viewModel: SongCellIdentifiable? {
        didSet{
            updateView()
        }
    }
    
    lazy var trackNameLabel: UILabel  = {()-> UILabel in
        let label = UILabel()
        label.text = "Song"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trackMillsLabel: UILabel = { ()-> UILabel in
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Light", size: 10)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
 
    
    override func layoutSubviews() {
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .white
        addSubview(trackNameLabel)
        addSubview(trackMillsLabel)
        trackNameLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        trackNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        trackMillsLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3).isActive = true
        trackMillsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        trackMillsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: trackNameLabel.trailingAnchor, constant: 10).isActive = true
        trackMillsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    private func updateView(){
        guard let viewModel = viewModel as? SongCellViewModel else { return }
        trackNameLabel.text = viewModel.trackName
        let secondFormatted = (viewModel.restOfSeconds < 10) ? "0" + String(viewModel.restOfSeconds) : String(viewModel.restOfSeconds)
        trackMillsLabel.text = "\(Int(viewModel.minutes)):\(secondFormatted)"
        
    }
}
