//
//  Dictionary.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.09.22.
//

import Foundation
extension Dictionary {

    

    func percentEncoded() -> Data? {

        

        return map { key, value in

            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""

            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""

            return escapedKey + "=" + escapedValue

        }

        .joined(separator: "&")

        .data(using: .utf8)

    }

}
extension CharacterSet {

    

    static let urlQueryValueAllowed: CharacterSet = {

        let generalDelimitersToEncode = ":#[]@"

        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed

        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return allowed

    }()

}
