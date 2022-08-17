//
//  DesignListViewModel.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.08.22.
//

import Foundation
final class DesignListViewModel {

    

    func getDesignList(_ completion: @escaping(Result<[ElemBlock], Error>) -> Void) {

        

        NetworkManager.shared.makeDesignRequest { result in

            switch result {

            case .failure(let error):

                completion(.failure(error))

            case .success(let information):
                completion(.success(DesignListDisplayFactory.makeDesignList(information: information)))
                

                

               

            }

        }

    }

}
