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
        if drinks == nil { self.drinks = [] }
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

enum Ice: Int,Codable {
    case roomTemp = 0
    case noIce = 1
    case normalIce = 2
    case lessIce = 3
    case lowIce = 4
    var value: String {
        switch self{
        case .roomTemp:
            return "常溫"
        case .noIce:
            return "去冰"
        case .normalIce:
            return "正常冰"
        case .lessIce:
            return "少冰"
        case .lowIce:
            return "微冰"
        }
    }
}

enum Size: String,Codable {
    case large = "大杯"
    case mid = "中杯"
}

enum Sugar: Int,Codable {
    case noSugar = 0
    case lowSugar = 1
    case halfSugar = 2
    case lessSugar = 3
    case standard = 4
    var value: String {
        switch self {
            case .noSugar:
                return "無糖"
            case .lowSugar:
                return "微糖"
            case .halfSugar:
                return "半糖"
            case .lessSugar:
                return "少糖"
            case .standard:
                return "正常甜"
        }
    }
}



/*
無糖 no sugar
微糖 low/light sugar (= 30%)
半糖 half sugar (= 50%)
少糖 less sugar (= 70%)
正常甜 standard
*/

/*
 去冰 no ice
 微冰 low/light ice
 少冰 less ice
 正常冰 normal
 常溫 room temperature
 */
