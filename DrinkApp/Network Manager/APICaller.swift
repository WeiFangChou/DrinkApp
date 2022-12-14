//
//  APICaller.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation
import UIKit


class APICaller {
    
    static var baseURL = "https://api.domain.dev"
    static let shared = APICaller()
    
    
    func getMenu(complection: @escaping(Result<[Menu] ,Error>) -> ()) {
        if let url = URL(string: APICaller.baseURL + "get/milkshamenu") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    complection(.failure(error))
                    return
                }
                do{
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode([Menu].self, from: data)
                        complection(.success(response))
                    }
                }catch{
                    print(error)
                    complection(.failure(error))
                }
            }.resume()
        }
        
    }
    
    func createOrder(order: Order,complection: @escaping(Result<Order, Error>)-> ()) {
        if let url = URL(string: APICaller.baseURL + "order" ){
            let jsonEncoder = JSONEncoder()
            let jsonDecoder = JSONDecoder()
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let content = try? jsonEncoder.encode(order)
            guard let content = content else { return }
            request.httpBody = content
                URLSession.shared.dataTask(with: request) { data, response, error in
                    do{
                        if let error = error {
                            complection(.failure(error))
                            return
                        }
                        if let data = data {
                            let result = try jsonDecoder.decode(Order.self, from: data)
                            complection(.success(result))
                        }
                    }catch(let error){
                        print(error)
                        complection(.failure(error))
                    }
                }.resume()
        }
        
    }
    func updateOrder(order: Order,complection: @escaping(Result<Order, Error>)-> ()) {
        if let orderUUID = order.id {
            if let url = URL(string: APICaller.baseURL + "order/\(orderUUID)" ){
                let jsonEncoder = JSONEncoder()
                let jsonDecoder = JSONDecoder()
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let content = try? jsonEncoder.encode(order)
//                print(String(data: content!, encoding: .utf8))
                request.httpBody = content
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        do{
                            if let error = error {
                                complection(.failure(error))
                                return
                            }
                            if let data = data {
                                let result = try jsonDecoder.decode(Order.self, from: data)
                                complection(.success(result))
                            }
                        }catch (let error){
                            print(error)
                            complection(.failure(error))
                        }
                    }.resume()
            }
        }
        
    }
    func getOrder(order: Order,complection: @escaping(Result<Order, Error>)-> ()) {
        if let orderUUID = order.id {
            if let url = URL(string: APICaller.baseURL + "order/\(orderUUID)" ){
                let jsonDecoder = JSONDecoder()
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                URLSession.shared.dataTask(with: request) { data, response, error in
                    do{
                        if let error = error {
                            complection(.failure(error))
                            return
                        }
                        if let data = data {
                            let result = try jsonDecoder.decode(Order.self, from: data)
                            complection(.success(result))
                        }
                    }catch (let error){
                        complection(.failure(error))
                    }
                }.resume()
                
            }
        }
        
    }
    func deleteOrder(order: Order,complection: @escaping(Result<String, Error>)-> ()) {
        if let orderUUID = order.id {
            if let url = URL(string: APICaller.baseURL + "order/\(orderUUID)" ){
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print(error)
                        complection(.failure(error))
                        return
                    }
                    if let data = data, let result = String(data: data, encoding: .utf8) {
                        print(result)
                        if result.hasPrefix("Success"){
                            complection(.success(result))
                        }else{
                            print("Failed to delete Order")
                        }
                    }
                }.resume()
                
            }
        }
    }
    
    func getOrders(orderUUID: String,complection: @escaping(Result<[Order], Error>)-> ()) {
        if let orderUUID = UUID(uuidString: orderUUID) {
            if let url = URL(string: APICaller.baseURL + "orders/\(orderUUID)" ){
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                URLSession.shared.dataTask(with: url) { data, response, error in
                    do{
                        if let error = error {
                            complection(.failure(error))
                            return
                        }
                        if let data = data {
                            let result = try jsonDecoder.decode([Order].self, from: data)
                            complection(.success(result))
                        }
                    }catch (let error){
                        complection(.failure(error))
                    }
                }.resume()
            }
        }
        
    }
    
}
