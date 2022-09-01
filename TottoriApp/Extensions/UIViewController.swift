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
    func showMapView(){
        let view = MapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 0.9).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.18181818182).isActive = true
        SwiftEntryKit.display(entry: view, using: setUpAttributesForMap())
    }
    func showCustomAlert(text : String){
        

        let view = CustomAllertView()
        view.setLabelText(text: text)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 0.9).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.18181818182).isActive = true
        SwiftEntryKit.display(entry: view, using: setUpAttributes())
        
    }
    private func setUpAttributes() -> EKAttributes{
        var attributes = defaultAttributes()
        attributes.screenInteraction = .absorbTouches
        let action : () -> () = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }
        attributes.entryInteraction.customTapActions.append(action)

       
        return attributes
    }
    private func setUpAttributesForMap() -> EKAttributes{
        var attributes = defaultAttributes()
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        return attributes
    }
    private func defaultAttributes() -> EKAttributes{
        var attributes = EKAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0 / 255.0, alpha: 0.3), dark: UIColor(white: 50.0 / 255.0, alpha: 0.3)))
        attributes.shadow = .active(with: .init(color : .black, opacity: 0.3, radius: 8))
        attributes.statusBar = .dark
        return attributes
    }
    
    

}
extension ViewControllerWithViewWithStack{
    
    
    func setPage<T>(targetContentOffset : UnsafeMutablePointer<CGPoint>,array : [T]){
        if let viewWithStack = viewWithStack{
            let currentIndex = (targetContentOffset.pointee.x / (UIScreen.main.bounds.width - 20)).rounded(.toNearestOrAwayFromZero)
            
            
            
            if currentIndex == 0{
                viewWithStack.confirmStack(stack: viewWithStack.hStack, j: 2)
                viewWithStack.hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
                viewWithStack.hStack.subviews[1].layer.borderColor = UIColor.clear.cgColor
                viewWithStack.hStack.subviews[2].layer.borderColor = UIColor.clear.cgColor
            }
            else if currentIndex == CGFloat((array.count) - 1){
                viewWithStack.hStack.subviews[0].layer.borderColor = UIColor.clear.cgColor
                viewWithStack.hStack.subviews[1].layer.borderColor = UIColor.clear.cgColor
                viewWithStack.hStack.subviews[2].layer.borderColor = UIColor.red.cgColor
                
                viewWithStack.confirmStack(stack: viewWithStack.hStack, j: (array.count) - 1)
                
            }
            else {
                viewWithStack.confirmStack(stack: viewWithStack.hStack, j: Int(currentIndex) + 1)
                viewWithStack.hStack.subviews[0].layer.borderColor = UIColor.clear.cgColor
                viewWithStack.hStack.subviews[1].layer.borderColor = UIColor.red.cgColor
                viewWithStack.hStack.subviews[2].layer.borderColor = UIColor.clear.cgColor
                
                
            }
        }
        
    }
}
