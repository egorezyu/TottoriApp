//
//  Allert.swift
//  TottoriApp
//
//  Created by Егор Родионов on 4.08.22.
//

import Foundation
import UIKit
extension UIAlertController{
    static public func createAllert(text : String) -> UIAlertController{
        
        let alertAboutRequest = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alertAboutRequest.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        return alertAboutRequest
        
    }
}
