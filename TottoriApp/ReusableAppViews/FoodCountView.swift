//
//  FoodCountView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.07.22.
//

import UIKit
import SwiftUI

class FoodCountView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
        setBorder()
    }
    private lazy var plusImage : UIImageView = {
        var image = UIImageView(image: UIImage(named: "plus")?.withTintColor(UIColor.myLightGrey,renderingMode: .alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
        
    }()
    private lazy var minusImage : UIImageView = {
        var image = UIImageView(image: UIImage(named: "minus")?.withTintColor(UIColor.myLightGrey,renderingMode: .alwaysOriginal))
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    public lazy var increaseAmountButton : ButtonWithIndexes = {
        let button = ButtonWithIndexes()
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    public lazy var decreaseAmountButton : ButtonWithIndexes = {
        let button = ButtonWithIndexes()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    public lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.textColor = UIColor.myLightGrey
        label.font = UIFont(name: "Gilroy", size: CGFloat(UIScreen.main.bounds.width / 10.833))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private lazy var hStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.addArrangedSubview(decreaseAmountButton)
        stack.addArrangedSubview(countLabel)
        stack.addArrangedSubview(increaseAmountButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
        
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView(){
        addSubview(increaseAmountButton)
        addSubview(decreaseAmountButton)
        addSubview(countLabel)
        decreaseAmountButton.addSubview(minusImage)
        increaseAmountButton.addSubview(plusImage)
        
        
        
    }
    private func setConstraints(){
        
        countLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        decreaseAmountButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor,constant: -5).isActive = true
        decreaseAmountButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        decreaseAmountButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        decreaseAmountButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        plusImage.centerYAnchor.constraint(equalTo: increaseAmountButton.centerYAnchor).isActive = true
        plusImage.centerXAnchor.constraint(equalTo: increaseAmountButton.centerXAnchor).isActive = true
        plusImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        plusImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        
        minusImage.centerXAnchor.constraint(equalTo: decreaseAmountButton.centerXAnchor).isActive = true
        minusImage.centerYAnchor.constraint(equalTo: decreaseAmountButton.centerYAnchor).isActive = true
        minusImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        minusImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        
        increaseAmountButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor,constant: 5).isActive = true
        increaseAmountButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        increaseAmountButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        increaseAmountButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        
        
        
        
        
        
    }
    private func setBorder(){
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 0.8
    }
    
    
    
    
}
