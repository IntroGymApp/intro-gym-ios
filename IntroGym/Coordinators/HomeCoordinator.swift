//
//  HomeCoordinator.swift
//  IntroGym
//
//  Created by Дывак Максим on 18.03.2025.
//

import UIKit

final class HomeCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    
    func start() -> UINavigationController {
        let homeVC = HomeViewController()
        navigationController.viewControllers = [homeVC]
        
        navigationController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home-icon"), tag: 0)
        
        return navigationController
    }
}
