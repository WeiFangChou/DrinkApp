//
//  Extension.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation
import UIKit


extension UIImageView {
    
    func fetchImagefromURL(fromURL: String) {
        if let url = URL(string: fromURL){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.image = UIImage(systemName: "photo")
                    return
                }
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
    
    
}


extension UIColor {
    static let MilkGreen = UIColor(red:  77/254, green: 126/254, blue: 35/254, alpha: 1)
}
