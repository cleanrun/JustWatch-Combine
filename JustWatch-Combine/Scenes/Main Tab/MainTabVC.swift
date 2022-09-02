//
//  MainTabVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import UIKit

class MainTabVC: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let movieVC = MovieListVC()
        let movieNavigationController = UINavigationController(rootViewController: movieVC)
        let movieTabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        movieVC.tabBarItem = movieTabBarItem
        
        let tvVC = TVListVC()
        let tvNavigationController = UINavigationController(rootViewController: tvVC)
        let tvTabBarItem = UITabBarItem(title: "TV", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv.fill"))
        tvVC.tabBarItem = tvTabBarItem
        
        let searchVC = SearchVC()
        let searchNavigationController = UINavigationController(rootViewController: searchVC)
        let searchTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        searchVC.tabBarItem = searchTabBarItem
        
        viewControllers = [movieNavigationController, tvNavigationController, searchNavigationController]
    }

}
