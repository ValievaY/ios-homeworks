//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Apple Mac Air on 21.01.2023.
//

import UIKit

protocol AppCoordinator: AnyObject {
    
    var parentCoordinator: MainBaseCoordinator? { get set }
    
    var rootViewController: UIViewController { get set }
    
    func start() -> UIViewController
    
    @discardableResult func resetToRoot() -> Self
}

extension AppCoordinator {
    
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
