//
//  TextFieldControlColorProtol.swift
//  TottoriApp
//
//  Created by Егор Родионов on 10.08.22.
//

import Foundation
import UIKit
protocol TextFieldControlColorProtocol : AnyObject{
    var selectedTextField : UITextField? {get set}
    func controlAlgoColor(currentField : UITextField)
}
extension TextFieldControlColorProtocol where Self : UIViewController{
    func controlAlgoColor(currentField : UITextField){
        if let selectedTextField = selectedTextField {
            currentField.subviews[0].backgroundColor = .red
            selectedTextField.subviews[0].backgroundColor = .gray
        }
        else{
            currentField.subviews[0].backgroundColor = .red
           
        }
        selectedTextField = currentField
        
    }
}
