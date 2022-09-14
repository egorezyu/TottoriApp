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
        label.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        label.textColor = UIColor.myLightGrey
        return label
        
    }
    private func generateTextField(hint : String) -> UITextField{
        let textField = CustomTextFieldWithInsets()
        
        textField.placeholder = hint
        let rectangleView = UIView()
        rectangleView.backgroundColor = .gray
        textField.addSubview(rectangleView)
        textField.textColor = .myLightGrey
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
        vStack.spacing = 10
        vStack.distribution = .fillEqually
        vStack.addArrangedSubview(generateLabel(name: name))
        vStack.addArrangedSubview(generateTextField(hint: name))
        return vStack
        
    }
    func generateGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = 3
        let animationGroup = makeAnimationGroup()
        animationGroup.beginTime = 0.0
        gradientLayer.add(animationGroup, forKey: "backgroundColor")
        self.layer.addSublayer(gradientLayer)
        

       
        
    }
    func makeAnimationGroup() -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGrey.cgColor
        anim1.toValue = UIColor.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0
        
        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration
        
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false
        
//        if let previousGroup = previousGroup {
//            // Offset groups by 0.33 seconds for effect
//            group.beginTime = previousGroup.beginTime + 0.33
//        }
        
        return group
    }
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
    
    static func getHeightOfAboutUsDataView() -> CGFloat {
        return UIScreen.main.bounds.width / 0.28
    }
    
}
