//
//  TabBarController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    var coords: LocationCoordinates = LocationCoordinates(latitude: 21, longitude: 23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(rgb: 0xFD2D55)

        viewControllers = [
            generateViewController(rootViewController: WeatherViewController(), image: UIImage(systemName: "sun.and.horizon")!, title: "Погода"),
            generateViewController(rootViewController: SearchViewController(), image: UIImage(systemName: "magnifyingglass")!, title: "Поиск")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.backgroundColor = .white
        navigationVC.navigationBar.prefersLargeTitles = true
        rootViewController.title = title
        return navigationVC
    }
}

