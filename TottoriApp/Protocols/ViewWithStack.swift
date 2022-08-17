//
//  ViewWithStack.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.08.22.
//

import Foundation
import UIKit
protocol ViewWithStack : AnyObject{
    var hStack : UIStackView {get set}
    func confirmStack(stack : UIStackView,j : Int)
}
extension ViewWithStack {
    func confirmStack(stack : UIStackView,j : Int){
        var dictionary : [Int : Int] = [:]
        dictionary[0] = j - 2
        dictionary[1] = j - 1
        dictionary[2] = j
        for (key,value) in dictionary{
            (stack.subviews[key] as! UILabel).text = String(value + 1)
            
            
        }
       
        
    }
    
}
