//
//  UIView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 10.08.22.
//

import Foundation
import UIKit
extension UIView{
    func generateLabel(name : String) -> UILabel{
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 27.8571428571)
        label.textColor = UIColor.myLightGrey
        return label
        
    }
    private func generateTextField(hint : String) -> UITextField{
        let textField = CustomTextFieldWithInsets()
    
        textField.placeholder = hint
        let rectangleView = UIView()
        rectangleView.backgroundColor = .gray
        //add
        textField.addSubview(rectangleView)
        
        //constraints for bottom line
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        rectangleView.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        rectangleView.centerXAnchor.constraint(equalTo: textField.centerXAnchor).isActive = true
        
        return textField
        
    }
    func generateStackWithLabelAndField(name : String) -> UIStackView{
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 27
        vStack.distribution = .fillEqually
        vStack.addArrangedSubview(generateLabel(name: name))
        vStack.addArrangedSubview(generateTextField(hint: name))
        return vStack
        
    }
    static func getHeightOfAboutUsDataView() -> CGFloat {
        return UIScreen.main.bounds.width / 0.39
    }
    
}
