//
//  PhoneFieldProtocol.swift
//  TottoriApp
//
//  Created by Егор Родионов on 10.08.22.
//

import Foundation
import UIKit
protocol PhoneFieldProtocol : AnyObject{
    var vStackPhone : UIStackView {get set}
    func controlPhoneFieldAlgo()
    
}
extension PhoneFieldProtocol{
    func controlPhoneFieldAlgo(){
        let phoneText = vStackPhone.subviews[1] as? CustomTextFieldWithInsets
        if let textInput = phoneText?.text{
            if textInput.count == 1{
                phoneText?.text?.append("7")
            }
            else if textInput.count > 18{
                phoneText?.text?.removeLast()
            }
            else{
                phoneText?.text = textInput.format(with: "+X (XXX) XXX-XX-XX")
            }
            
        }
    }
}
