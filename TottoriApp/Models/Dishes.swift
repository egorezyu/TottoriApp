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
    let menuList: [MenuList]
}

// MARK: - MenuList
struct MenuList : Codable {
    let sectionID, sectionName: String
    let sectionList: [SectionList]?
}

// MARK: - SectionList
struct SectionList : Codable {
    let foodID, foodName, foodPrice, foodImage0: String
    let foodContent: String
    let foodWeight: String?
    let foodImage1: String
    let foodImage2, foodImage3: String?
}
