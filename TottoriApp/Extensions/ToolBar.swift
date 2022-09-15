//
//  ToolBar.swift
//  TottoriApp
//
//  Created by Егор Родионов on 10.08.22.
//

import Foundation
import UIKit
extension UIToolbar {
    
    static func toolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .red
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: NSLocalizedString("done_button_time", comment: ""), style: UIBarButtonItem.Style.plain, target: nil, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
}
