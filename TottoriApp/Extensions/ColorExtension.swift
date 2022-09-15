//
//  ColorExtension.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import Foundation
import UIKit
extension UIColor{
    static let backGroundColor = UIColor(named: "BackGroundColor")
    static let labelColor = UIColor(named: "LabelColor")
    static let borderColor = UIColor(named: "BorderColor")
    static let myLightGrey = UIColor(red: 0.275, green: 0.286, blue: 0.31, alpha: 1)
    static let myRed = UIColor(red: 0.969, green: 0.169, blue: 0.071, alpha: 1).cgColor
    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }
    
    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 240, green: 201 / 240, blue: 201 / 240, alpha: 1)
    }
    
}
