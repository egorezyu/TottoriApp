//
//  DetailsView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 6.09.22.
//

import UIKit

class DetailsView: UIView {
//    public var section : Int!
//    public var index : Int!
    lazy var detailsLabel : TextWithIndexes = {
        let label = TextWithIndexes()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont(name: "Gilroy-Regular", size: 14)
        label.text = NSLocalizedString("more", comment: "")
        label.isUserInteractionEnabled = true
//        label.backgroundColor = .red
        return label
       
        
    }()
    lazy var detailsButton : ButtonWithIndexes = {
        let button = ButtonWithIndexes()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "chevron.right")?.withTintColor(.black,renderingMode: .alwaysOriginal), for: .normal)
//        button.backgroundColor = .red
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
        backgroundColor = .clear
    }
    private func addViews(){
        addSubview(detailsLabel)
        addSubview(detailsButton)
        
    }
    private func setConstraints(){
        detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        detailsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailsLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
        detailsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailsButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        detailsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
