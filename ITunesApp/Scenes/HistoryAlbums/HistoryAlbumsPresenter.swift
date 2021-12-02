//
//  HistoryAlbumsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import Foundation


protocol HistoryAlbumsPresentationLogic {
    func presentHistoryAlbums(response: HistoryAlbums.PresentingHistory.Response)
}

final class HistoryAlbumsPresenter: HistoryAlbumsPresentationLogic {
    var viewController: HistoryAlbumsDisplayLogic?

    func presentHistoryAlbums(response: HistoryAlbums.PresentingHistory.Response) {
        
        var requests: [HistoryCellViewModel] = []
        response.historyRequests.forEach { searchRequest in
            requests.append(HistoryCellViewModel.init(historyRequest: searchRequest))
        }
        viewController?.displaySearchRequests(viewModel: HistoryAlbums.PresentingHistory.ViewModel.init(rows: requests))
        
    }
}
