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
    public lazy var increaseAmountButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
        
    }()
    public lazy var decreaseAmountButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    public lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont(name: "Gilroy", size: 36)
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
//        addSubview(hStack)
        
        
    }
    private func setConstraints(){
//        hStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
//        hStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
//        hStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
//        hStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        decreaseAmountButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor,constant: -20).isActive = true
        decreaseAmountButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        decreaseAmountButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        decreaseAmountButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        increaseAmountButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor,constant: 20).isActive = true
        increaseAmountButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        increaseAmountButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        increaseAmountButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        
    }
    private func setBorder(){
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 0.8
    }
    

    

}
