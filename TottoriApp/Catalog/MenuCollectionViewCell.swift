//
//  MenuCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    lazy var typeLabel : UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = .labelColor
        typeLabel.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 30)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        return typeLabel

    }()
    override init(frame : CGRect){
        super.init(frame: frame)
        configureBorder()
      
        contentView.addSubview(typeLabel)
        setConstraints()
        
    }
    private func configureBorder(){
        contentView.layer.borderColor = UIColor.borderColor?.cgColor
        contentView.layer.borderWidth = 1
        
    }
    func setLabel(menuType : String){
        typeLabel.text = menuType
        
    }
    private func setConstraints(){
        typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        typeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    
}
