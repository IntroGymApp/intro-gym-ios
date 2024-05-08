//
//  TabBarController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        selectedIndex = 0
        tabBar.backgroundColor = .gray.withAlphaComponent(0.2)
    }
    
    private func setupTabs() {
        let mainViewController = MainViewController()
        let workoutViewController = WorkoutViewController()
        let guideViewController = GuideViewController()
        let statsViewController = StatsViewController()
        let profileViewController = ProfileViewController()
        
        let main = createNavigation(title: "Главная", image: UIImage(named: "main")!, viewController: mainViewController)
        let workout = createNavigation(title: "Тренировка", image: UIImage(named: "workout")!, viewController: workoutViewController)
        let guide = createNavigation(title: "Справочник", image: UIImage(named: "guide")!, viewController: guideViewController)
        let stats = createNavigation(title: "Статистика", image: UIImage(named: "stats")!, viewController: statsViewController)
        let profile = createNavigation(title: "Профиль", image: UIImage(named: "profile")!, viewController: profileViewController)
        
        setViewControllers([main, workout, guide, stats, profile], animated: true)
    }
    
    private func createNavigation(title: String, image: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        navigation.viewControllers.first?.navigationItem.title = title
        
        return navigation
    }
    
}
