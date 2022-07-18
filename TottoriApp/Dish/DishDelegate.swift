//
//  DishDelegate.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import Foundation
import Foundation
protocol DishDelegate : AnyObject{
    func increaseAmount()
    func decreaseAmount()
    func addToBasket()
    
}