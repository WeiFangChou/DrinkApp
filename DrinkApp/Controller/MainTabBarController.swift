//
//  HomeTabBarController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class MainTabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(APICaller.baseURL)
        
        let homeViewController = HomeViewController()
        let homeNavigationController = navController(controller: homeViewController, title: "菜單", selectedImage: #imageLiteral(resourceName: "menu selected.png"), unselectImage: #imageLiteral(resourceName: "menu selected"))
        
        let drinkViewController = PickUpViewController()
        let drinkNavigationController = navController(controller: drinkViewController, title: "訂飲料", selectedImage: #imageLiteral(resourceName: "drink selected.png"), unselectImage: #imageLiteral(resourceName: "drink unselect"))
        
        let shopViewController = ShopViewController()
        let shopNavigationController = navController(controller: shopViewController, title: "商店", selectedImage: #imageLiteral(resourceName: "shop selected"), unselectImage: #imageLiteral(resourceName: "shop unselect"))
        
        let historyViewController = HistoryViewController()
        historyViewController.delegate = drinkViewController
        let historyNavigationController = navController(controller: historyViewController, title: "最近訂單", selectedImage: #imageLiteral(resourceName: "history selected"), unselectImage: #imageLiteral(resourceName: "history unselect"))
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.black
        viewControllers = [homeNavigationController, drinkNavigationController, shopNavigationController, historyNavigationController]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    private func navController(controller: UIViewController, title: String, selectedImage: UIImage, unselectImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.image = unselectImage.withRenderingMode(.alwaysOriginal)
        navController.title = title
        navController.tabBarController?.tabBar.tintColor = .black
        navController.tabBarController?.tabBar.barTintColor = .white
        return navController
    }

    
}
