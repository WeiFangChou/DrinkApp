//
//  ShopBagViewController.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/29.
//

import UIKit



class ShopBagViewController: UIViewController {

    
    
    var order: Order?
    
    init(order: Order) {
        self.order = order
        print(self.order)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
