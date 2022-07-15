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
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    private lazy var foodType : UILabel = {
        var label = UILabel()
        
        label.font = UIFont(name: "FoglihtenNo06", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionAboutFood : UITextView = {
        var textView = UITextView()
        textView.textAlignment = .left
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "Gilroy-Regular", size: 14)
        
        
        return textView
        
    }()
    private lazy var price : UILabel = {
        var label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: 22)
        return label
        
    }()
    private lazy var ruble : UILabel = {
        var label = UILabel()
        label.text = "₽"
        label.font = UIFont(name: "Cormorant-Regular", size: 20)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var purchaseButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "purchase"), for: .normal)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
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
        contentView.addSubview(ruble)
        contentView.addSubview(purchaseButton)
        
    }
    private func setBackGround(){
        let image = UIImageView(image: UIImage(named: "backForCell"))
        image.frame = contentView.bounds
        image.contentMode = .scaleAspectFill
        contentView.addSubview(image)
        
        
        
    }
    
    private func setConstraints(){
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 21).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant:  133).isActive = true
        foodType.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        foodType.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionAboutFood.topAnchor.constraint(equalTo: foodType.bottomAnchor,constant: 5).isActive = true
        
        descriptionAboutFood.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        descriptionAboutFood.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        descriptionAboutFood.heightAnchor.constraint(equalToConstant: 162).isActive = true
        
        price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
        price.bottomAnchor.constraint(equalTo: descriptionAboutFood.bottomAnchor,constant: 26).isActive = true
        
        ruble.leadingAnchor.constraint(equalTo: price.trailingAnchor).isActive = true
        ruble.centerYAnchor.constraint(equalTo: price.centerYAnchor,constant: -3).isActive  = true
        
        purchaseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -18).isActive = true
        purchaseButton.bottomAnchor.constraint(equalTo: descriptionAboutFood.bottomAnchor,constant: 26).isActive = true
        purchaseButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func setCellFields(dish : Dish){
        self.imageView.image = dish.image
        self.foodType.text = dish.foodType
        self.descriptionAboutFood.text = dish.description
        self.price.text = String(dish.price)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
