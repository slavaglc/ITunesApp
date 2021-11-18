//
//  AlbumDetailsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



protocol AlbumDetailsPresentingLogic {
    func presentAlbumInfo(response: AlbumDetails.PresentingAlbum.Response)
}

final class AlbumDetailsPresenter: AlbumDetailsPresentingLogic {
    
    var viewController: AlbumDetailsDisplayLogic?
    
    func presentAlbumInfo(response: AlbumDetails.PresentingAlbum.Response) {
        let album = response.album
        let description = getDescription(for: response)
        let albumDetailsViewModel = AlbumDetailsViewModel(description: description, albumViewModel: AlbumDetailsViewModel.AlbumViewModel(album: album))
        viewController?.displayAlbumInfo(viewModel: albumDetailsViewModel)
    }
    
    
    
    private func getDescription(for response: AlbumDetails.PresentingAlbum.Response) -> String {
        let album = response.album
        let date = album.releaseDate?.components(separatedBy: "T")
        let unknow = "Unknow"
        let day = date?.first ?? unknow
        let time = date?.last?.filter({ char in char != "Z"}) ?? ""
        let description = """
            Artist: \(album.artist ?? unknow)
            Album: \(album.name ?? unknow)
            Release date: \(day) \(time)
            Country: \(album.country ?? unknow)
            """
        return description
    }
}
