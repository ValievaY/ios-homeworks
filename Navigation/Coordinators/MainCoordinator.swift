//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Apple Mac Air on 22.01.2023.
//

import UIKit

enum TabBarFlow {
    case feed
    case profile
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var feedCoordinator: FeedCoordinatorProtocol = FeedCoordinator()
    
    lazy var profileCoordinator: ProfileCoordinatorProtocol = ProfileCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        return setupTabBar()
    }
    
    func moveTo(flow: TabBarFlow) {
        switch flow {
        case .feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
    
    func resetToRoot() -> Self {
        feedCoordinator.resetToRoot()
        moveTo(flow: .feed)
        return self 
    }
    
    func setupTabBar() -> UIViewController {
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem (title: "Feed", image: UIImage(systemName: "heart.text.square"), tag: 0)

        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem (title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        UITabBar.appearance().tintColor = UIColor (red: 0/105.0, green: 0/105.0, blue: 236/105.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .systemGray6

        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, profileViewController]

        return rootViewController
    }
}
