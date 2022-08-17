//
//  MenuListViewModel.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import Foundation
final class MenuListViewModel {

    

    func getMenuList(_ completion: @escaping(Result<([MenuList],[MenuDish],[SectionList]), Error>) -> Void) {

        

        NetworkManager.shared.makeMenuListRequest() { result in

            switch result {

            case .failure(let error):

                completion(.failure(error))

            case .success(let information):
                completion(.success(MenuListDisplayFactory.makeMenuList(information: information)))
                

                

               

            }

        }

    }

}
