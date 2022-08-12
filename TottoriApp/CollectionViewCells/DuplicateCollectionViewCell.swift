//
//  DuplicateCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.08.22.
//

import UIKit

class DuplicateCollectionViewCell: UICollectionViewCell {
    static let id = "DuplicateCollectionViewCell"
    lazy var typeLabel : UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = .labelColor
        typeLabel.font = UIFont(name: "Gilroy", size: FontSizes.font13)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        return typeLabel

    }()
    override init(frame : CGRect){
        super.init(frame: frame)
        configureBorderAndColor()
      
        contentView.addSubview(typeLabel)
        setConstraints()
        
    }
    
    func configureBorderAndColor(){
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 2
        
        
    }
    func cleanEverything(){
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 1
        typeLabel.textColor = .labelColor
        
        
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
