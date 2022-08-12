//
//  UILabel.swift
//  TottoriApp
//
//  Created by Егор Родионов on 1.08.22.
//

import Foundation
import UIKit
extension UILabel{
    public func genetrateLabel(text : String ,color : UIColor,font : UIFont?,secondFont : UIFont? = nil){
        let baseString = text
        guard !baseString.isEmpty,let font = font else {
            return
        }

        let attributedString = NSMutableAttributedString(string: baseString, attributes: nil)
        

        
        attributedString.setAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: attributedString.length - 1))
        
        if let secondFont = secondFont{
            attributedString.setAttributes([NSAttributedString.Key.font: secondFont], range: NSRange(location: attributedString.length - 1, length: 1))
            
        }
    

        
       
        self.attributedText = attributedString
        self.textColor = color
        
        
    }
    
}
