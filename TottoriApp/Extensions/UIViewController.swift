//
//  UIViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 9.08.22.
//

import Foundation
import UIKit
extension UIViewController{
    
    func setBackkGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
    }
}
