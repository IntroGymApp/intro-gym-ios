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
        customizeTabBar()
        selectedIndex = 0
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
        
        setViewControllers([main, workout, guide, stats, profile], animated: false)
    }
    
    private func createNavigation(title: String, image: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        navigation.viewControllers.first?.navigationItem.title = title
        
        return navigation
    }
    
    private func customizeTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .backgroundBlock
        
        appearance.stackedLayoutAppearance.normal.iconColor = .main
        appearance.stackedLayoutAppearance.selected.iconColor = .accent
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "main") ?? .gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "accent") ?? .gray]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
}
