//
//  CustomBarItem.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/22.
//

import UIKit

class CustomBarItem: UITabBarItem {

    
    init(title: String, image: String) {
        super.init()
        
        self.title = title
        self.image = UIImage(named: image)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
