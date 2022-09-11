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
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    func phoneIsValid() -> Bool{
        
        guard self.count != 1 else {
            return false
            
        }
        let char = self[self.index(self.startIndex, offsetBy: 1)]
        if char == "9"{
            if self.count == 11{
                return true
            }
            return false
        }
        
        return false
        
        
    }
    func format(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                
                result.append(numbers[index])
                
                
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) 
            }
        }
        return result
    }
    
}
