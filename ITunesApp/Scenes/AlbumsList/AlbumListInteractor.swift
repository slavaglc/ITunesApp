//
//  AlbumsInteractor.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 12.11.2021.
//

import Foundation


protocol AlbumListBusinessLogic {
    func fetchAlbums(for searchType: SearchingType)
}

protocol AlbumListDataStore {
    var albums: [Album] { get }
    var searchText: String? { get set }
}

final class AlbumListInteractor: AlbumListDataStore {
    var searchText: String? {
        didSet {
            if let searchText = searchText {
                fetchAlbums(for: .searchingFor(searchText))
                presenter?.presentSearchText(text: searchText)
            }
        }
    }
    
    var presenter: AlbumListPresentationLogic?
    var albums: [Album] = []
    
    private func saveToHistory(for searchType: SearchingType) {
        switch searchType {
        case .random:
            break
        case .searchingFor(let string):
            guard !string.isEmpty else { break }
            HistoryManager.shared.saveHistory(for: string)
        }
    }
    
}

extension AlbumListInteractor: AlbumListBusinessLogic {
    
    func fetchAlbums(for searchType: SearchingType) {
        presenter?.presentSearchCondition()
        var searchType = searchType
        
        switch searchType {
        case .random:
            break
        case .searchingFor(let string):
            searchType =  string.isEmpty ? SearchingType.random : SearchingType.searchingFor(string)
        }
        
        NetworkManager.shared.fetchAlbumsData(for: searchType) { [weak self] albums in
            let sortedAlbums = albums.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == ComparisonResult.orderedAscending
            }
            self?.albums = sortedAlbums
            let response = AlbumList.PresentingAlbums.Response(albums: sortedAlbums)
            self?.saveToHistory(for: searchType)
            self?.presenter?.presentAlbums(response: response)
        }
    }
}
