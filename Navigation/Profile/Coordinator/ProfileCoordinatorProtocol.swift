//
//  ProfileCoordinatorProtocol.swift
//  Navigation
//
//  Created by Apple Mac Air on 26.01.2023.
//

import Foundation

protocol ProfileCoordinatorProtocol: AppCoordinator {
    
    var userService: UserService? { get set }
    
    func toProfile()
    
    func debugReales()
    
    func check (_ login: String, _ password: String) -> Bool
    
    func authorization (_ login: String) -> User?
    
    func userProfile(_ loginText: String)
}
