//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Apple Mac Air on 25.01.2023.
//

import UIKit

class ProfileCoordinator: ProfileCoordinatorProtocol {
    
    var userService: UserService?
   
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    let profileViewController = ProfileViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: LogInViewController(coordinator: self))
        return rootViewController
    }
    
    func toProfile() {
        navigationRootViewController?.pushViewController(profileViewController, animated: true)
    }
    
    func debugReales() {
#if DEBUG
        userService = TestUserService()
#else
        userService = CurrentUserService()
#endif
    }
    
    func check(_ login: String, _ password: String) -> Bool {
        return Checker.shared.check(login, password)
    }
    
    func authorization(_ login: String) -> User? {
        return login == userService?.user?.login ? userService?.user : nil
    }
    
    func userProfile(_ loginText: String) {
        profileViewController.user = userService?.authorization(loginText)
    }
}
