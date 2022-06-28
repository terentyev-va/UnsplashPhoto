//
//  MainTabBarController.swift
//  UnsplashPhoto
//
//  Created by Вячеслав Терентьев on 28.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .none
        
        setupTabBar()
        setupViews()
    }
        
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        UITabBar.appearance().barTintColor = .black
        UINavigationBar.appearance().barTintColor = .black
    }

    private func setupViews() {
        let photosVC = PhotosViewController()
        let albumVC = AlbumViewController()
        let photosNavVC = UINavigationController(rootViewController: photosVC)
        let albunNavVC = UINavigationController(rootViewController: albumVC)

        setViewControllers([photosNavVC, albunNavVC], animated: true)

        guard let items = tabBar.items else { return }

        items[0].title = "Photos"
        items[1].title = "Album"

        items[0].image = UIImage(systemName: "photo")
        items[1].image = UIImage(systemName: "photo.on.rectangle.angled")
    }
    
}
