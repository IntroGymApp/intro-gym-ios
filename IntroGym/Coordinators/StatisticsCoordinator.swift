//
//  StatisticsCoordinator.swift
//  IntroGym
//
//  Created by Дывак Максим on 18.03.2025.
//

import UIKit

final class StatisticsCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    
    func start() -> UINavigationController {
        let statisticsVC = StatisticsViewController()
        navigationController.viewControllers = [statisticsVC]
        
        navigationController.tabBarItem = UITabBarItem(title: "Профиль", image: nil, tag: 4)
        
        return navigationController
    }
}
