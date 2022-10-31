//
//  HomeTabBarController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    let homeViewController = HomeViewController()
    let drinkViewController = PickUpViewController()
    let shopViewController = ShopViewController()
    let historyViewController = HistoryViewController()
    var homeBarItem = CustomBarItem(title: "Home", image: "shop")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navigationHomeView = UINavigationController(rootViewController: homeViewController)
        let navigationDrinkView = UINavigationController(rootViewController: drinkViewController)
        let navigationShopView = UINavigationController(rootViewController: shopViewController)
        let navigationHistoryView = UINavigationController(rootViewController: historyViewController)
        historyViewController.delegate = drinkViewController
        navigationHomeView.navigationBar.barTintColor = .MilkGreen
        navigationHomeView.tabBarItem.title = "菜單"
        
        
        navigationDrinkView.tabBarItem.image = UIImage(named: "")
        navigationDrinkView.tabBarItem.selectedImage = UIImage(named: "")
        navigationDrinkView.tabBarItem.title = "訂飲料"
        navigationDrinkView.navigationBar.barTintColor = .MilkGreen
        navigationDrinkView.setNavigationBarHidden(true, animated: true)
        
        navigationShopView.tabBarItem.image = UIImage(named: "")
        navigationShopView.tabBarItem.selectedImage = UIImage(named: "")
        navigationShopView.navigationBar.barTintColor = .MilkGreen
        navigationShopView.tabBarItem.title = "商店"
        
        navigationHistoryView.tabBarItem.image = UIImage(named: "")
        navigationHistoryView.tabBarItem.selectedImage = UIImage(named: "")
        navigationHistoryView.navigationBar.barTintColor = .MilkGreen
        navigationHistoryView.tabBarItem.title = "歷史訂單"
        
        setViewControllers([navigationHomeView, navigationShopView, navigationDrinkView , navigationHistoryView], animated: true)
       
//        tabBar.backgroundColor = UIColor(named: "MilkGreen")
        view.backgroundColor = .MilkGreen
        tabBar.tintColor = .MilkGreen
//        tabBar.unselectedItemTintColor = .gray
        
    }
    

    
    func settingTabbarItem() {

    }
    
    @objc func tapPickButton() {
        
        print("Pickup")
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }

    
}
