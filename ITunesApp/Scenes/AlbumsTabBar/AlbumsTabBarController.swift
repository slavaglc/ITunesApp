//
//  AlbumsTabBarController.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 30.11.2021.
//

import UIKit


final class AlbumsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumsTabBarConfigurator.shared.configure(with: self)
    }
    
}

class TemporaryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
