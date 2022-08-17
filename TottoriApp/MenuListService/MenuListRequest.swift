//
//  MenuListRequest.swift
//  TottoriApp
//
//  Created by Егор Родионов on 19.07.22.
//

import Foundation

struct MenuListRequest: Request {

    

    typealias Response = Catalog

    

    var path: URL = URL(string: "http://tottori.fixmaski.ru/api/getSubMenuDelivery.php")!

    

    struct Catalog : Codable {
        let status: Bool
        let menuList: [MenuList]?
        let menuDishes: [MenuDish]?
    }

    // MARK: - MenuDish
    struct MenuDish : Codable {
        let foodID, foodName, foodPrice, foodImage0: String?
        let foodContent: String?
    }

    // MARK: - MenuList
    struct MenuList : Codable {
        let sectionID, sectionName: String?
        let sectionList: [SectionList]?
    }

    // MARK: - SectionList
    struct SectionList : Codable {
        let foodID, foodName, foodPrice: String?
        let foodImage0: String?
        
        let foodContent: String
        let foodWeight: String?
        let foodImage1: String?
        let foodImage2, foodImage3: String?
    }


}

