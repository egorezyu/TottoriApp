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
    let foodWeight2: String?
    let foodPrice2: String?
    let foodID, foodName, foodPrice, foodImage0: String
    let foodContent: String
    let foodWeight: String?
    let foodImage1: String
    let foodImage2, foodImage3: String?
    var count = 1
    var isOnFirstWeight = true
    var currentPrice : String {
        if isOnFirstWeight{
            return String(count * (Int(foodPrice) ?? 0))
        }
        else{
            return  String(count * (Int(foodPrice2 ?? "-1") ?? 0))
        }
        
    }
    
    var isSecondWeight : Bool {
        if foodWeight2 != nil {
            return true
        }
        else{
            return false
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
        if isOnFirstWeight{
            if let foodWeight = foodWeight {
                return foodWeight + " г"
            }
            else{
                return "-"
            }
        }
        else{
            if let foodWeight2 = foodWeight2 {
                return foodWeight2 + " г"
            }
            else{
                return "-"
            }
        }
        
        
        
        
        
        
        
    }
    var sum : Int{
        if isOnFirstWeight{
            return count * (Int(foodPrice) ?? -1)
        }
        else{
            return count * (Int(foodPrice2 ?? "") ?? -1)
        }
    }
    
}
extension SectionList : Equatable {
    static func ==(lhs: SectionList, rhs: SectionList) -> Bool {
        return lhs.foodID == rhs.foodID && lhs.isOnFirstWeight == rhs.isOnFirstWeight
    }
    
}
