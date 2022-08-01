//
//  UILabel.swift
//  TottoriApp
//
//  Created by Егор Родионов on 1.08.22.
//

import Foundation
import UIKit
extension UILabel{
    public func genetrateLabel(text : String ,color : UIColor,font : UIFont?){
        let baseString = text

        let attributedString = NSMutableAttributedString(string: baseString, attributes: nil)
        

        
        attributedString.setAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: attributedString.length - 1))
    

        
       
        self.attributedText = attributedString
        self.textColor = .red
        
        
    }
    
}
