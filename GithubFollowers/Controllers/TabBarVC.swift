//
//  TabBarVC.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()

    }
    
    private func configure() {
        let tabBarAppereance = UITabBarAppearance()
        tabBarAppereance.configureWithOpaqueBackground()
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppereance
        } else {
            tabBar.standardAppearance = tabBarAppereance
        }
        
        viewControllers = [createSearchNavControllers(), createFavoritesNavControllers()]
        tabBar.tintColor = .systemGreen
        
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    private func createSearchNavControllers() -> UINavigationController {
        let vc = SearchVC()
        vc.title = "Search"
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = "Search"
        
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let appereance = UINavigationBarAppearance()
        appereance.configureWithTransparentBackground()
        
        if #available(iOS 15.0, *){
            navController.navigationBar.scrollEdgeAppearance = appereance
        }
        else{
            navController.navigationBar.standardAppearance = appereance
        }
        
        return navController
    }
    private func createFavoritesNavControllers() -> UINavigationController {
        let vc = FavoritesListVC()
        vc.title = "Favorites"
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = "Favorites"

        
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let appereance = UINavigationBarAppearance()
        appereance.configureWithTransparentBackground()
        
        if #available(iOS 15.0, *){
            navController.navigationBar.scrollEdgeAppearance = appereance
        }
        else{
            navController.navigationBar.standardAppearance = appereance
        }
        
        return navController
    }


}
