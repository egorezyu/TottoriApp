//
//  String.swift
//  TottoriApp
//
//  Created by Егор Родионов on 16.07.22.
//

import Foundation
extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
