//
//  MenuListDisplayFactory.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation
struct MenuListDisplayFactory {

    

    static func makeMenuList(information: MenuListRequest.Catalog) -> ([MenuList],[MenuDish]) {

        

        let catalog = information

        var arrayOfLovelyDishes = [MenuDish]()

        var arrayOfMenu = [MenuList]()
        arrayOfMenu.append(MenuList(sectionID: "", sectionName: "Все",sectionList: []))
        if let menu = catalog.menuList {
            menu.forEach {


                let sectionID : String = $0.sectionID ?? ""
                let sectionName : String = $0.sectionName ?? ""
                var sectionList : [SectionList]? = []
                $0.sectionList?.forEach{
                    let foodID : String = $0.foodID ?? ""
                    let foodName : String = $0.foodName ?? ""
                    let foodPrice : String = $0.foodPrice ?? ""
                    let foodImage0 = $0.foodImage0 ?? ""
                    let foodContent = $0.foodContent
                    let foodWeight = $0.foodWeight
                    let foodImage1 = $0.foodImage1 ?? ""
                    let foodImame2 = $0.foodImage2
                    let foodImage3 = $0.foodImage3
                    let el = SectionList(foodID: foodID, foodName: foodName, foodPrice: foodPrice, foodImage0: foodImage0, foodContent: foodContent, foodWeight: foodWeight, foodImage1: foodImage1, foodImage2: foodImame2, foodImage3: foodImage3)
                    sectionList?.append(el)
                    arrayOfMenu[0].sectionList?.append(el)
                    
                   
                    
                    
                }

                

               

                

                let element = MenuList(

                    sectionID: sectionID, sectionName: sectionName, sectionList: sectionList)

                arrayOfMenu.append(element)

            }
        }
        if let lovelyDises = catalog.menuDishes{
            lovelyDises.forEach {
                let foodID : String = $0.foodID ?? ""
                let foodName : String = $0.foodName ?? ""
                let foodPrice : String = $0.foodPrice ?? ""
                let foodImage0 : String = $0.foodImage0 ?? ""
                let foodContent : String = $0.foodContent ?? ""
                let el = MenuDish(foodID: foodID, foodName: foodName, foodPrice: foodPrice, foodImage0: foodImage0, foodContent: foodContent)
                arrayOfLovelyDishes.append(el)
                
            }
        }

        

        return (arrayOfMenu,arrayOfLovelyDishes)

    }

}
