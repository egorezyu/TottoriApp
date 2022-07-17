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
       
        return button
        
    }()
    public lazy var decreaseAmountButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        
        return button
        
    }()
    public lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont(name: "Gilroy", size: 36)
        
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
        addSubview(hStack)
        
        
    }
    private func setConstraints(){
        hStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        hStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        hStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        hStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        
        
    }
    private func setBorder(){
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 2
    }
    

    

}
