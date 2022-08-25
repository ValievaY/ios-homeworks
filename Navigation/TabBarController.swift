

import UIKit

class TabBarController: UITabBarController {
    
    var feedNavigationController : UINavigationController!
    var profileNavigationControoller : UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarUI()
    }
    
    private func tabBarUI () {
        feedNavigationController = UINavigationController.init(rootViewController: FeedViewController ())
        profileNavigationControoller = UINavigationController.init(rootViewController: ProfileViewController())
        
        self.viewControllers = [feedNavigationController, profileNavigationControoller]
        
        feedNavigationController.tabBarItem = UITabBarItem (title: "Feed", image: UIImage(systemName: "heart.text.square"), tag: 0)
        profileNavigationControoller.tabBarItem = UITabBarItem (title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        UITabBar.appearance().tintColor = UIColor (red: 0/105.0, green: 0/105.0, blue: 236/105.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .lightGray
        
    }
}

