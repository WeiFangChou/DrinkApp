//
//  Extension.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(key: String, fromURL: String)  -> UIImageView {
        let imageView = UIImageView()
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempFileUrl = tempDirectory.appendingPathComponent(key)
        print(tempFileUrl.path)
        if FileManager.default.fileExists(atPath: tempFileUrl.path) {
            DispatchQueue.main.async {
                self.image = UIImage(contentsOfFile: tempFileUrl.path)
            }
        }else{
            imageView.image = nil
            if let url = URL(string: fromURL) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = data{
                        try? data.write(to: tempFileUrl)
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
        
        return imageView
    }
    
    func load(from urlString: String){
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
        
        
    }
    
    
}


extension UIColor {
    static let MilkGreen = UIColor(red:  77/254, green: 126/254, blue: 35/254, alpha: 1)
    static let SkyBlue = UIColor(red: 135/254, green: 206/254, blue: 235/254, alpha: 1)
}
