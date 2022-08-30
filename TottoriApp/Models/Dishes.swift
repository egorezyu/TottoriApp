//
//  Dishes.swift
//  TottoriApp
//
//  Created by Егор Родионов on 16.07.22.
//

import Foundation
// MARK: - Welcome3
struct Catalog : Codable {
    let status: Bool
    var menuList: [MenuList]
    var menuDishes: [MenuDish]
}

// MARK: - MenuDish
struct MenuDish : Codable {
    let foodID, foodName, foodPrice, foodImage0: String
    let foodContent: String
    var formattedPrice : String{
        (Formatter.separator.string(from: NSNumber(value: Int(foodPrice) ?? 0)) ?? "") + " ₽"
    }
}


// MARK: - MenuList
struct MenuList : Codable {
    let sectionID, sectionName: String
    var sectionList: [SectionList]?
}

// MARK: - SectionList
struct SectionList : Codable {
    let foodID, foodName, foodPrice, foodImage0: String
    let foodContent: String
    let foodWeight: String?
    let foodImage1: String
    let foodImage2, foodImage3: String?
    var count = 1
    var currentPrice : String {
        return String(count * (Int(foodPrice) ?? 0))
    }
    var currentWeight : String? {
        if let foodWeight = foodWeight {
            return String(count * (Int(foodWeight) ?? 0))
        }
        else{
            return nil
        }
        
        
    }
    mutating func plusCount(){
        if self.count < 10{
            self.count = self.count + 1
        }
        
    }
    mutating func minusFunc(){
        if self.count != 0{
            self.count = self.count - 1
        }
        
    }
    mutating func addAmountToCount(count : Int){
        self.count = self.count + count
    }
    mutating func setCountZero(){
        self.count = 0
    }
    var formattedPrice : String{
        (Formatter.separator.string(from: NSNumber(value: Int(currentPrice) ?? 0)) ?? "") + " ₽"
    }
    var formattedWeight : String{
        if let currentWeight = currentWeight {
            return (Formatter.separator.string(from: NSNumber(value: Int(currentWeight) ?? 0)) ?? "") + " г"
        }
        else{
            return "—"
        }

        
        
    }
}
