//
//  Delivery.swift
//  TottoriApp
//
//  Created by Егор Родионов on 30.08.22.
//

import Foundation
struct Order : Codable {
    let orderComment, phone, flat, paymentMethod: String
    let entrance, intercom, street: String
    let foodList: [FoodList]
    let city, floor, email, house: String
    let name: String
}

// MARK: - FoodList
struct FoodList : Codable {
    let foodAmount: Int
    let foodID, foodName: String
}
