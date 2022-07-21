//
//  BadgeView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 21.07.22.
//

import UIKit

class BadgeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
        setCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public lazy var countLabel : UILabel = {
        var label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        label.textAlignment = .center
        
    
        return label
        
    }()
    private func setCornerRadius(){
        layer.cornerRadius = 10
        backgroundColor = .red
        
    }
    private func addView(){
        addSubview(countLabel)
    }
    private func setConstraints(){
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }

    
    

}
