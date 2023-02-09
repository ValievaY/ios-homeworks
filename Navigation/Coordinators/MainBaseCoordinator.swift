//
//  MainBaseCoordinator.swift
//  Navigation
//
//  Created by Apple Mac Air on 26.01.2023.
//

import Foundation

protocol MainBaseCoordinator: AppCoordinator {
    var feedCoordinator: FeedCoordinatorProtocol { get }
    var profileCoordinator: ProfileCoordinatorProtocol { get }
    
    func moveTo(flow: TabBarFlow)
}
