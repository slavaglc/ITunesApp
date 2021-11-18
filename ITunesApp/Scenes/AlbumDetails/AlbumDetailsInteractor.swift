//
//  AlbumDetailsInteractor.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



protocol AlbumDetailsBusinessLogic {
    func fetchAlbumData()
    func fetchSongList()
}

protocol AlbumDetailsDataStore {
    var album: Album? { get set }
}

final class AlbumDetailsInteractor: AlbumDetailsDataStore, AlbumDetailsBusinessLogic  {
    
    
    var presenter: AlbumDetailsPresentingLogic?
    var album: Album?
    
    func fetchAlbumData() {
        guard let album = album else { return }
        let response = AlbumDetails.PresentingAlbum.Response.init(album: album)
        presenter?.presentAlbumInfo(response: response)
    }
    
//    func fetchAlbumImage() {
//        guard let album = album else { return }
//        guard let url = album.imageURL else { return }
//        ImageManager.shared.fetchImage(url: url) { [weak self] imageData, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let imageData = imageData {
//                let response = AlbumDetails.PresentingAlbum.ImageResponse(imageData: imageData)
//                self?.presenter?.presentAlbumImage(response: response)
//            }
//        }
//    }
    
    
    func fetchSongList() {
         
    }
    
   
}



