//
//  HistoryAlbumsModels.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 01.12.2021.
//

import Foundation


protocol HistoryCellIdentifiable {
    var identifier: String { get }
}

typealias HistoryCellViewModel = HistoryAlbums.PresentingHistory.ViewModel.HistoryCellViewModel

enum HistoryAlbums {
    struct PresentingHistory {
        struct Response {
            let historyRequests: [String]
        }
        
        struct ViewModel {
            let rows: [HistoryCellViewModel]
            struct HistoryCellViewModel: HistoryCellIdentifiable {
                var historyRequest: String
                var identifier: String {
                    HistoryTableViewCell.nameOfClass
                }
            }
        }
    }
}
