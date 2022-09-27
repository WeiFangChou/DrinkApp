//
//  APICaller.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation


class APICaller {
    
    var menuBaseURL = "http://127.0.0.1:8080/get/milkshamenu"
    
    static let shared = APICaller()
    
    func getMenu(complection: @escaping(Result<[DrinksMenu] ,Error>) -> ()) {
        print(menuBaseURL)
        if let url = URL(string: menuBaseURL) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    complection(.failure(error))
                    return
                }
                do{
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode([DrinksMenu].self, from: data)
                        complection(.success(response))
                    }
                }catch{
                    print(error)
                    complection(.failure(error))
                }
            }.resume()
        }
        
    }
    
    
}
