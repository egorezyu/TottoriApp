//
//  AboutUsDelegate.swift
//  TottoriApp
//
//  Created by Егор Родионов on 9.08.22.
//

import Foundation
import UIKit
protocol AboutUsDelegate : AnyObject{
    func switchTextField(sender : UITextField)
    func postRequest(sender : UIButton)
    func switchTogle(sender : UIButton)
    func phoneTextFieldTapped(sender : UITextField)
    func textEditing(sender : UITextField)
    
}
