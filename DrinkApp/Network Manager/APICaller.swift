//
//  APICaller.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation


class APICaller {
    
    static var menuBaseURL = "http://api.fangs.dev/get/milkshamenu"
    static let shared = APICaller()
    
    
    
    func getMenu(complection: @escaping(Result<[DrinksMenu] ,Error>) -> ()) {
        if let url = URL(string: APICaller.menuBaseURL) {
            
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
