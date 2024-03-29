//
//  HeaderForTitleCollectionReusableView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import UIKit

class HeaderForTitle: UICollectionReusableView {
    static let headerReuseIdentifier = "headerReuseIdentifier"
    
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
           
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 14),
            
        ])
        textLabel = label
        textLabel.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273)
        textLabel.textColor = .myLightGrey
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
