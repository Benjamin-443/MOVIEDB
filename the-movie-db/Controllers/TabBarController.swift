//
//  TabBarController.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup
    private func setup() {
        let listMoviesItem = UITabBarItem(
            title: "Filmes",
            image: UIImage(named: "icon-film"),
            selectedImage: UIImage(named: "icon-film"))
        let listMoviesViewController = ListMoviesViewController(nibName: "ListMoviesViewController", bundle: nil)
        listMoviesViewController.tabBarItem = listMoviesItem
        let moviesNavigation = createNavigation(with: listMoviesViewController)

        let listFavoritesItem = UITabBarItem(
            title: "Favoritos",
            image: UIImage(named: "icon-star"),
            selectedImage: UIImage(named: "icon-star"))
        let listfavoritesViewController = ListFavoritesViewController(nibName: "ListFavoritesViewController", bundle: nil)
        listfavoritesViewController.tabBarItem = listFavoritesItem
        let favoritesNavigation = createNavigation(with: listfavoritesViewController)
        
        let infoItem = UITabBarItem(
            title: "Info",
            image: UIImage(named: "icon-info"),
            selectedImage: UIImage(named: "icon-info"))
        let infoViewController = InfoViewController(nibName: "InfoViewController", bundle: nil)
        infoViewController.tabBarItem = infoItem
        let infoNavigation = createNavigation(with: infoViewController)

        self.viewControllers = [moviesNavigation, favoritesNavigation, infoNavigation]
        self.selectedViewController = moviesNavigation
        self.selectedIndex = 0
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = Constants.color().lightGreen
        self.tabBar.unselectedItemTintColor = .white
    }

    private func createNavigation(with viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.titleTextAttributes = textAttributes
        navigation.navigationBar.largeTitleTextAttributes = textAttributes
        navigation.navigationBar.barStyle = .black
        navigation.navigationBar.tintColor = .white

        return navigation
    }
}
