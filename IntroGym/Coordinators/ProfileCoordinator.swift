//
//  ProfileCoodrinator.swift
//  IntroGym
//
//  Created by Дывак Максим on 18.03.2025.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    
    func start() -> UINavigationController {
        let profileVC = ProfileViewController()
        navigationController.viewControllers = [profileVC]
        
        navigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile-icon"), tag: 4)
        
        return navigationController
    }
}
