//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Apple Mac Air on 25.01.2023.
//

import UIKit

class FeedCoordinator: FeedCoordinatorProtocol {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedViewController(coordinator: self))
        return rootViewController
    }
    
    func toPostView() {
        let postView = PostViewController()
        navigationRootViewController?.pushViewController(postView, animated: true)
    }
}
