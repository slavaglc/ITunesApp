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

protocol HistoryAlbumsDataStore {
    var searchRequests: [String] { get }
}


final class HistoryAlbumsInteractor: HistoryAlbumsDataStore {
    var presenter: HistoryAlbumsPresentationLogic?
    var searchRequests: [String] = []
    
    private func getSearchRequests(by  strings: [String]) -> [String] {
        searchRequests = strings
        searchRequests.reverse()
        return searchRequests
    }
}

extension HistoryAlbumsInteractor: HistoryAlbumsBusinessLogic {
    func fetchHistoryAlbums() {
        let history = HistoryManager.shared.fetchHistory()
        let response = HistoryAlbums.PresentingHistory.Response.init(historyRequests: getSearchRequests(by: history))
        presenter?.presentHistoryAlbums(response: response)
    }
}
