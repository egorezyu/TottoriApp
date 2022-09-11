//
//  CustomTextFieldWithInsets.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import UIKit

class CustomTextFieldWithInsets: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 5,
        bottom: 20,
        right: 20
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}
