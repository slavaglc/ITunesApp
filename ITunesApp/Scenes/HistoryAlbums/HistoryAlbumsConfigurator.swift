//
//  HistoryAlbumsConfigurator.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import Foundation


final class HistoryAlbumsConfigurator {
    static let shared = HistoryAlbumsConfigurator()
    
    private init() {}
    
    func configure(with viewController: HistoryAlbumsViewController) {
        let interactor = HistoryAlbumsInteractor()
        let presenter = HistoryAlbumsPresenter()
        let router = HistoryAlbumsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        
        viewController.tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.nameOfClass)
        viewController.tableView.delegate = viewController
        viewController.tableView.dataSource = viewController
        
    }
}
