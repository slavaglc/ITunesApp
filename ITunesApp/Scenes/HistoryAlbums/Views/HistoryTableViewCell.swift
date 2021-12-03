//
//  HistoryTableViewCell.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import UIKit


protocol HistoryTableViewCellRepresentable {
    var viewModel: HistoryCellIdentifiable? { get }
}

final class HistoryTableViewCell: UITableViewCell, HistoryTableViewCellRepresentable {
    
    var viewModel: HistoryCellIdentifiable? {
        didSet {
            updateView()
        }
    }
    
    lazy var searchRequestLabel: UILabel  = {()-> UILabel in
        let label = UILabel()
        label.text = "Request"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        initiazile()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initiazile() {
        
        backgroundColor = .white
        addSubview(searchRequestLabel)
        searchRequestLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2).isActive = true
        searchRequestLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 1.2).isActive = true
        searchRequestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        searchRequestLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? HistoryCellViewModel else { return }
        searchRequestLabel.text = viewModel.historyRequest
    }

}
