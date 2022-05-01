//
//  TabBarController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white

        let searchVC = SearchViewController()
        let weatherVC = WeatherViewController()
        let navigationVC = UINavigationController(rootViewController: searchVC)
        navigationVC.title = "Поиск"
        weatherVC.title = "Погода"
        navigationVC.navigationBar.backgroundColor = .white

        viewControllers = [
            weatherVC,
            navigationVC
        ]
    }
    
}
