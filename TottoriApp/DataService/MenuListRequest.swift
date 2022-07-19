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


}
struct MenuListDisplayFactory {

    

    static func makeMenuList(information: [MenuListRequest.MenuList]) -> [MenuList] {

        

        let menuList = information

        

        var array = [MenuList]()

        menuList.forEach {


            let sectionID = $0.sectionID
            let sectionName = $0.sectionName
            var sectionList : [SectionList]? = []
            $0.sectionList?.forEach{
                let foodID = $0.foodID
                let foodName = $0.foodName
                let foodPrice = $0.foodPrice
                let foodImage0 = $0.foodImage0
                let foodContent = $0.foodContent
                let foodWeight = $0.foodWeight
                let foodImage1 = $0.foodImage1
                let foodImame2 = $0.foodImage2
                let foodImage3 = $0.foodImage3
                let el = SectionList(foodID: foodID, foodName: foodName, foodPrice: foodPrice, foodImage0: foodImage0, foodContent: foodContent, foodWeight: foodWeight, foodImage1: foodImage1, foodImage2: foodImame2, foodImage3: foodImage3)
                sectionList?.append(el)
                
               
                
                
            }

            

           

            

            let element = MenuList(

                sectionID: sectionID, sectionName: sectionName, sectionList: sectionList)

            array.append(element)

        }

        return array

    }

}
final class MenuListViewModel {

    

    func getMenuList(_ completion: @escaping(_ items: [MenuList]) -> Void) {

        

        NetworkManager.shared.makeMenuListRequest() { result in

            switch result {

            case .failure(let error):

                print(error)

            case .success(let information):
                completion(MenuListDisplayFactory.makeMenuList(information: information.menuList))
                

                

               

            }

        }

    }

}
