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
    public convenience init?(hex: String) {
         let r, g, b, a: CGFloat

         if hex.hasPrefix("#") {
             let start = hex.index(hex.startIndex, offsetBy: 1)
             let hexColor = String(hex[start...])

             if hexColor.count == 8 {
                 let scanner = Scanner(string: hexColor)
                 var hexNumber: UInt64 = 0

                 if scanner.scanHexInt64(&hexNumber) {
                     r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                     g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                     b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                     a = CGFloat(hexNumber & 0x000000ff) / 255

                     self.init(red: r, green: g, blue: b, alpha: a)
                     return
                 }
             }
         }

         return nil
     }
}
