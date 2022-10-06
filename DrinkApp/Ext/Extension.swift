//
//  Extension.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation
import UIKit


extension UIImageView {
    
    func fetchImagefromURL(key: String, fromURL: String)  -> UIImageView {
        var imageView = UIImageView()
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempFileUrl = tempDirectory.appendingPathComponent(key)
        print(tempFileUrl.path)
        if FileManager.default.fileExists(atPath: tempFileUrl.path) {
            DispatchQueue.main.async {
                self.image = UIImage(contentsOfFile: tempFileUrl.path)!
            }
        }else{
            imageView.image = nil
            if let url = URL(string: fromURL) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        return
                    }
                    if let data = data{
                        try? data.write(to: tempFileUrl)
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: data)!
                        }
                    }
                }.resume()
            }
        }
        
        return imageView
    }
    
    
}


extension UIColor {
    static let MilkGreen = UIColor(red:  77/254, green: 126/254, blue: 35/254, alpha: 1)
    static let SkyBlue = UIColor(red: 135/254, green: 206/254, blue: 235/254, alpha: 1)
}
