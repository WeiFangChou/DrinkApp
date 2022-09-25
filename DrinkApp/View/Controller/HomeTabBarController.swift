//
//  HomeTabBarController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    var homeViewController = HomeViewController()
    var drinkViewController = PickUpViewController()
    var shopViewController = ShopViewController()
    var homeBarItem = CustomBarItem(title: "Home", image: "shop")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setViewControllers([homeViewController,drinkViewController,shopViewController], animated: true)
        tabBar.backgroundColor = UIColor(named: "MilkGreen")
        setMiddleButton()
    }
    

    
    func settingTabbarItem() {
        let image = UIImage(named: "shop")
        
        
        
    }
    
    @objc func tapPickButton() {
        
        print("Pickup")
        let viewcontroller = PickUpViewController()
        
        
        present(viewcontroller, animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
    func setMiddleButton() {
        let button = UIButton(frame: CGRect(x: (self.view.bounds.width/2) - 30, y: -20, width: 60, height: 60))
        
        button.setImage(UIImage(named: "shop_white"), for: .normal)
        button.setBackgroundImage(UIImage(named: "CustomBarItemColor"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "MilkGreen")?.cgColor
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 15
        button.layer.shadowColor = UIColor(named: "MilkGreen")?.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.tabBar.addSubview(button)
        button.addTarget(self, action: #selector(tapPickButton), for: .touchUpInside)
    }
    
    
}
