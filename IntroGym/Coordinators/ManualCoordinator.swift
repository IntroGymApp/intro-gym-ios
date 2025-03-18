//
//  ManualCoordinator.swift
//  IntroGym
//
//  Created by Дывак Максим on 18.03.2025.
//

import UIKit

final class ManualCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    
    func start() -> UINavigationController {
        let manualVC = ManualViewController()
        navigationController.viewControllers = [manualVC]
        
        navigationController.tabBarItem = UITabBarItem(title: "Справочник", image: UIImage(named: "list-icon"), tag: 2)
        
        return navigationController
    }
}
