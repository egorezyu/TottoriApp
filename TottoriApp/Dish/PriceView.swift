//
//  PriceView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 21.07.22.
//

import UIKit

class PriceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public lazy var price : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Gilroy", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    lazy var rubleLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Cormorant", size: 20)
        label.text = "₽"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addView(){
        addSubview(price)
        addSubview(rubleLabel)
        
        
        
    }
    private func setConstraints(){
        price.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        price.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        rubleLabel.leadingAnchor.constraint(equalTo: price.trailingAnchor,constant: 5).isActive = true
        rubleLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -9).isActive = true

        
        
        
        
        
    }

   

}
