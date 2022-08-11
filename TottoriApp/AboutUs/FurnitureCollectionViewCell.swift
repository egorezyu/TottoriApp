//
//  FurnitureCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.08.22.
//

import UIKit

class FurnitureCollectionViewCell: UICollectionViewCell {
    static public var id = "FurnitureCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addViews()
        setConstraints()
    }
    private lazy var label : UILabel = {
        var label = UILabel()
        label.text = "  Здесь будет апи \n про дизайн"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        
       
        return label
        
    }()
    private func addViews(){
        contentView.addSubview(label)
    }
    private func setConstraints(){
        
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
