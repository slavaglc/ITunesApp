//
//  AlbumDetailsPresenter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation
import UIKit



protocol AlbumDetailsPresentingLogic {
    func presentAlbumInfo(response: AlbumDetails.PresentingAlbum.Response)
    func presentSongList(response: AlbumDetails.PresentingSongs.Response)
    func presentActivityIndicator()
    func presentFinishOfLoadCondition()
}

final class AlbumDetailsPresenter: AlbumDetailsPresentingLogic {
    
    var viewController: AlbumDetailsDisplayLogic?
    
    func presentAlbumInfo(response: AlbumDetails.PresentingAlbum.Response) {
        let album = response.album
        let description = getDescription(for: response)
        let albumDetailsViewModel = AlbumDetailsViewModel(description: description, albumViewModel: AlbumDetailsViewModel.AlbumViewModel(album: album))
        viewController?.displayAlbumInfo(viewModel: albumDetailsViewModel)
    }
    
    func presentSongList(response: AlbumDetails.PresentingSongs.Response) {
        let songs = response.songs
        var rows: [SongCellViewModel] = []
        songs.forEach { song in
            rows.append(SongCellViewModel.init(song: song))
        }
        let viewModel = SongsViewModel.init(rows: rows)
        viewController?.displaySongs(viewModel: viewModel)
        presentFinishOfLoadCondition()
    }
    
    func presentActivityIndicator() {
        viewController?.activityIndicator.startAnimating()
    }
    
    func presentFinishOfLoadCondition() {
        viewController?.songsLoaded = false
        viewController?.activityIndicator.stopAnimating()
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
            Track count: \(album.trackCount ?? 0)
            Release date: \(day) \(time)
            Country: \(album.country ?? unknow)
            """
        return description
    }
}
