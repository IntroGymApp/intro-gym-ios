//
//  WorkoutsCoordinator.swift
//  IntroGym
//
//  Created by Дывак Максим on 18.03.2025.
//

import UIKit

final class WorkoutsCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    
    func start() -> UINavigationController {
        let workoutsVC = WorkoutsViewController()
        navigationController.viewControllers = [workoutsVC]
        
        navigationController.tabBarItem = UITabBarItem(title: "Тренировки", image: nil, tag: 1)
        
        return navigationController
    }
}
