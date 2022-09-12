//
//  DesignListViewModel.swift
//  TottoriApp
//
//  Created by Егор Родионов on 30.08.22.
//

import Foundation
import Foundation
final class DeliveryListViewModel {

    

    func getDelivList(data : String,_ completion: @escaping(Result<DeliveryPostRequest.Response, Error>) -> Void) {

        

        NetworkManager.shared.delivPostRequest(data: data) { result in
            completion(result)
        }

    }

}
