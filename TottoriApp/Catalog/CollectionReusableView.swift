//
//  CollectionReusableView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 3.08.22.
//

import UIKit

class MyHeaderClass: UICollectionReusableView {
    static let headerReuseIdentifier = "headerReuseIdentifier"
    
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor,constant: UIScreen.main.bounds.height / 10),
           
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            
        ])
        textLabel = label
        textLabel.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MySecondHeaderClass: UICollectionReusableView {
    static let headerReuseIdentifier = "headerSecondReuseIdentifier"
    
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor,constant: UIScreen.main.bounds.height / 10),
           
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            
        ])
        textLabel = label
        backgroundColor = .red
        textLabel.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

