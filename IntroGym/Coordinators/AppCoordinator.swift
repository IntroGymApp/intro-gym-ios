//
//  AppCoordinator.swift
//  IntroGym
//
//  Created by Дывак Максим on 18.03.2025.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let tabBarController = UITabBarController()
    
    private let homeCoordinator = HomeCoordinator()
    private let workoutsCoordinator = WorkoutsCoordinator()
    private let manualCoordinator = ManualCoordinator()
    private let statisticsCoordinator = StatisticsCoordinator()
    private let profileCoordinator = ProfileCoordinator()

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        tabBarController.viewControllers = [
            homeCoordinator.start(),
            workoutsCoordinator.start(),
            manualCoordinator.start(),
            statisticsCoordinator.start(),
            profileCoordinator.start()
        ]
        tabBarController.tabBar.tintColor = AppColors.accent
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
