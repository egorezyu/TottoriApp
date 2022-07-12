//
//  DishCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit

class DishCollectionViewCell: UICollectionViewCell {
    static let identifier = "DishCollectionViewCell"
    private lazy var imageView : UIImageView = {
        var image = UIImageView(image: UIImage(named: "dish"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    private lazy var foodType : UILabel = {
        var label = UILabel()
        label.text = "Кайсен Рамен"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionAboutFood : UITextView = {
        var textView = UITextView()
        textView.textAlignment = .left
        textView.text = "Рамен из водорослей комбу и грибов Шиитаке, со светлой соевой основой, тигровыми креветками, мясом краба, королевскими креветками, яйцом нитамаго."
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
        
    }()
    private lazy var price : UILabel = {
        var label = UILabel()
        label.text = "1440"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        return label
        
    }()
    override init(frame : CGRect){
        super.init(frame: frame)
        setBackGround()
        addSubViewS()
        setConstraints()
        
    }
    private func addSubViewS() {
        contentView.addSubview(imageView)
        contentView.addSubview(foodType)
        contentView.addSubview(descriptionAboutFood)
        contentView.addSubview(price)
        
    }
    private func setBackGround(){
        if let image = UIImage(named: "backForCell"){
            contentView.backgroundColor = UIColor(patternImage: image)
        }
        
        
        
    }
    
    private func setConstraints(){
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant:  133).isActive = true
        foodType.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        foodType.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionAboutFood.topAnchor.constraint(equalTo: foodType.bottomAnchor,constant: 5).isActive = true
        
        descriptionAboutFood.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        descriptionAboutFood.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        descriptionAboutFood.heightAnchor.constraint(equalToConstant: 162).isActive = true
        
        price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        price.topAnchor.constraint(equalTo: descriptionAboutFood.bottomAnchor,constant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
