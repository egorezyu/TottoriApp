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
    var currentWeight : String {
        return String(count * (Int(foodWeight ?? "") ?? 0))
        
    }
    mutating func plusCount(){
        self.count = self.count + 1
    }
    mutating func minusFunc(){
        if self.count != 1{
            self.count = self.count - 1
        }
        
    }
    mutating func addAmountToCount(count : Int){
        self.count = self.count + count
    }
}
