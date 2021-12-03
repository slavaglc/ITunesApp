//
//  HistoryAlbumsInteractor.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import Foundation


protocol HistoryAlbumsBusinessLogic {
    func fetchHistoryAlbums()
}


final class HistoryAlbumsInteractor {
    
    var presenter: HistoryAlbumsPresentationLogic?
    
}

extension HistoryAlbumsInteractor: HistoryAlbumsBusinessLogic {
    func fetchHistoryAlbums() {
        var history = HistoryManager.shared.fetchHistory()
        history.reverse()
        let response = HistoryAlbums.PresentingHistory.Response.init(historyRequests: history)
        presenter?.presentHistoryAlbums(response: response)
    }

}
