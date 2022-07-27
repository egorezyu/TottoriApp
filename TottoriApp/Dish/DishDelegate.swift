//
//  DishDelegate.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import Foundation
import Foundation
import UIKit
protocol DishDelegate : AnyObject{
    func increaseAmount()
    func decreaseAmount()
    func addToBasket()
    func backButtonAction()
    func forwardButtonAction()
    func imageButtonTapped(sender : UIButton)
    
    
}
