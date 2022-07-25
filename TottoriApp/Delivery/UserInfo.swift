//
//  UserInfo.swift
//  TottoriApp
//
//  Created by Егор Родионов on 25.07.22.
//

import Foundation
struct UserInfo : Codable,Equatable{
    var name : String
    var phone : String
    var mail : String
    var street : String
    var home : String
    var floorAndFlat : String
}
