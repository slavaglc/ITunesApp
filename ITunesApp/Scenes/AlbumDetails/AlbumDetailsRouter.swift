//
//  AlbumDetailsRouter.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 14.11.2021.
//

import Foundation



protocol AlbumDetailsDataPassing {
    var dataStore: AlbumDetailsDataStore? { get }
}

@objc protocol AlbumDetailsRoutingLogic {
    
}

final class AlbumDetailsRouter: NSObject, AlbumDetailsDataPassing, AlbumDetailsRoutingLogic {
    
    var viewController: AlbumDetailsDisplayLogic?
    var dataStore: AlbumDetailsDataStore?
    
}
