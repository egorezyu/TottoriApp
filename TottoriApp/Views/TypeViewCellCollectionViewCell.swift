//
//  TypeViewCellCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit

class TypeViewCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "TypeCollectionViewCell"
    var typeView = TypeView()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        typeView.frame = bounds
        addSubview(typeView)
        setConstraints()
        
        
    }
    func setType(type : String){
        
        self.typeView.setType(type: type)
       
        
        
    }
    private func setConstraints(){
        typeView.translatesAutoresizingMaskIntoConstraints = false
        typeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        typeView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        typeView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        typeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
