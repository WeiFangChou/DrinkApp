//
//  Order.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/16.
//

import Foundation


struct Order: Codable {
    
    var id: UUID?
    var orderID: String?
    var shopName: String
    var shopAddress: String
    var orderUUID: UUID
    var drinks: [Drinks]?
    var createdate: String
    
    mutating func addDrink(drink: Drinks){
        if drinks == nil {
            self.drinks = []
        }
            
            self.drinks?.append(drink)
        
    }
}


struct Drinks: Codable {
    var id: UUID
    var name: String
    var size: String
    var cost: Int
    var ice: Int
    var sweet: Int
    var addon: [String]?
}
