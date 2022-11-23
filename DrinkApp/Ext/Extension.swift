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
//    
//    func load(from urlString: String?, keyString: String) -> UIImage?{
//        if let imageFromCache = imageCache.object(forKey: keyString as NSString) as? UIImage {
//            self.image = imageFromCache
//            return self.image
//        }
//        guard let url = urlString, let url = URL(string: url) else {
//            return nil
//        }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        imageCache.setObject(image, forKey: keyString as NSString)
//                        self.image = image
//                    }
//                }
//            }
//        }
//        return self.image
//    }
    
    func fetchImagefromURL(key: String, fromURL: String?) {
        var imageView = UIImageView()
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempFileUrl = tempDirectory.appendingPathComponent(key)
//        print(tempFileUrl.path)
        if FileManager.default.fileExists(atPath: tempFileUrl.path) {
            DispatchQueue.main.async {
                self.image = UIImage(contentsOfFile: tempFileUrl.path)
            }
        }else{
            imageView.image = nil
            if let fromURL = fromURL , let url = URL(string: fromURL) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    if let data = data{
                        try? data.write(to: tempFileUrl)
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
    }
    
}


extension UIColor {
    static let MilkGreen = UIColor(red:  77/254, green: 126/254, blue: 35/254, alpha: 1)
    static let SkyBlue = UIColor(red: 135/254, green: 206/254, blue: 235/254, alpha: 1)
}

extension UIViewController {
    
    func showAlertView(title: String?, message: String,complection: @escaping(AlertError)-> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { action in
            complection(.OKAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { cancelAction in
            complection(.CancelAction)
        }
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func showAlertView(title: String?, message: String, complection: @escaping ()->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alertController, animated: true) {
            sleep(2)
            self.dismiss(animated: true) {
                complection()
            }
        }
    }
    
}

enum AlertError: Error {
    case OKAction
    case CancelAction
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0,
                widthConstant: CGFloat = 0, heighConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(top.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(left.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let right = right {
            anchors.append(right.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottom.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if rightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heighConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
}
