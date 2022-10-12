//
//  Shop.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/12.
//

import Foundation


struct Shop:Codable {
    var shopName: String
    var shopAddress: String
    var shopLatitude: Double
    var shopLongitude: Double
    var shopCity: String
    var shopCountry: String
    var shopBusiness: [Business]
    
}


struct Business:Codable {
    var Monday: Hours
    var Tuesday: Hours
    var Wednesday: Hours
    var Thursday: Hours
    var Friday: Hours
    var Saturday: Hours
    var Sunday: Hours
    
}

struct Hours: Codable{
    var StartTime: Int
    var EndTime: Int
}
