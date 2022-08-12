//
//  UIViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 9.08.22.
//

import Foundation
import UIKit
import SwiftEntryKit
extension UIViewController{
    
    func setBackGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
    }
    func showOkAlert(){
        

        let view = CustomAllertView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 0.9).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.18181818182).isActive = true
        SwiftEntryKit.display(entry: view, using: setUpAttributes())
        
    }
    private func setUpAttributes() -> EKAttributes{
        var attributes = EKAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0 / 255.0, alpha: 0.3), dark: UIColor(white: 50.0 / 255.0, alpha: 0.3)))
        attributes.shadow = .active(with: .init(color : .black, opacity: 0.3, radius: 8))
        attributes.statusBar = .dark
        attributes.screenInteraction = .absorbTouches
        let action : () -> () = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }
        attributes.entryInteraction.customTapActions.append(action)

       
        return attributes
    }

}
