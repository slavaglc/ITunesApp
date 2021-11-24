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
}

final class AlbumListInteractor: AlbumListDataStore {
    var presenter: AlbumListPresentationLogic?
    var albums: [Album] = []
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
            self?.presenter?.presentAlbums(response: response)
        }
    }
}
