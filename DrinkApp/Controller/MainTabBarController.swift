//
//  HomeTabBarController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let homeViewController = HomeViewController()
        let homeNavigationController = navController(controller: homeViewController, title: "菜單", selectedImage: #imageLiteral(resourceName: "menu selected.png"), unselectImage: #imageLiteral(resourceName: "menu selected"))
        
        let drinkViewController = PickUpViewController()
        let drinkNavigationController = navController(controller: drinkViewController, title: "訂飲料", selectedImage: #imageLiteral(resourceName: "drink selected.png"), unselectImage: #imageLiteral(resourceName: "drink unselect"))
        
        let shopViewController = ShopViewController()
        let shopNavigationController = navController(controller: shopViewController, title: "商店", selectedImage: #imageLiteral(resourceName: "shop selected"), unselectImage: #imageLiteral(resourceName: "shop unselect"))
        
        let historyViewController = HistoryViewController()
        historyViewController.delegate = drinkViewController
        let historyNavigationController = navController(controller: historyViewController, title: "最近訂單", selectedImage: #imageLiteral(resourceName: "history selected"), unselectImage: #imageLiteral(resourceName: "history unselect"))
        
        tabBar.tintColor = .black
        viewControllers = [homeNavigationController, drinkNavigationController, shopNavigationController, historyNavigationController]
        
    }
    
    private func navController(controller: UIViewController, title: String, selectedImage: UIImage, unselectImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.image = unselectImage.withRenderingMode(.alwaysOriginal)
        navController.title = title
        
        return navController
    }

    
    func settingTabbarItem() {

    }
    
    @objc func tapPickButton() {
        
        print("Pickup")
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }

    
}
