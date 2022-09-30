

import UIKit

class TabBarController: UITabBarController {
    
    var feedNavigationController : UINavigationController!
    var logInViewController : UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarUI()
    }
    
    private func tabBarUI () {
        feedNavigationController = UINavigationController.init(rootViewController: FeedViewController ())
        logInViewController = UINavigationController.init(rootViewController: LogInViewController())
        
        self.viewControllers = [feedNavigationController, logInViewController]
        
        feedNavigationController.tabBarItem = UITabBarItem (title: "Feed", image: UIImage(systemName: "heart.text.square"), tag: 0)
        logInViewController.tabBarItem = UITabBarItem (title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        UITabBar.appearance().tintColor = UIColor (red: 0/105.0, green: 0/105.0, blue: 236/105.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .systemGray6
        
    }
}

