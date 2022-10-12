//
//  DrinksMenu.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import Foundation


/*
 "remark":"(娜杯/伯爵/大正)",
 "largePrice":60,
 "recommend":false,
 "id":"1BAF727A-0426-44AD-BD14-1D1F92AA86AA",
 "caffeine":true,
 "midPrice":null,
 "cold":true,
 "hot":false,
 "type":"KUMO雲奶霜",
 "name":"KUMO紅茶",
 "new":false,
 */

struct DrinksMenu: Codable {
    let id: UUID
    let name : String
    let type : String
    let midPrice: Int?
    let largePrice : Int
    let hot : Bool
    let cold : Bool
    let caffeine : Bool
    let recommend : Bool
    let new : Bool
    let remark : String?
    let imageurl :String
}
