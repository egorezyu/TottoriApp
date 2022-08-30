//
//  DeliveryPostRequest.swift
//  TottoriApp
//
//  Created by Егор Родионов on 30.08.22.
//

import Foundation
struct DeliveryPostRequest : Request{
    typealias response = DelivResponse
    var path: URL = URL(string: "http://tottori.fixmaski.ru/api/order.php")!
    struct DelivResponse : Codable{
        var status : Bool
        var message : String
        
    }
    
    
}
