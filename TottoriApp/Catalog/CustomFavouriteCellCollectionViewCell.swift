//
//  CustomFavouriteCellCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 3.08.22.
//

import UIKit

class CustomFavouriteCell: UICollectionViewCell {
    static let id = "FavCell"
    override init(frame : CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
    }
    
    private lazy var label : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 13)
        label.text = "Рамен, которым     \n   можно гордиться"
        label.numberOfLines = 2
        return label
        
    }()
    private lazy var image : UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func addView(){
        contentView.addSubview(label)
        contentView.addSubview(image)
        
    }
    private func setConstraints(){
        label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        image.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 20).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 40).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40).isActive = true
        image.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3).isActive = true
        
    }
    func configureCell(sectionList : SectionList?){
        if let sectionList = sectionList {
            
            DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: image)
        }
        
        
        
        
        
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
