//
//  DeliveryDelegate.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import Foundation
import UIKit
protocol DeliveryDelegate : AnyObject{
    func postRequest()
    func switchTextField(sender : UITextField)
    func switchPayment(sender : UIButton)
    func textEditing(sender : UITextField)
    func phoneTextFieldTapped(sender : UITextField)
    
}
