//
//  DishCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit
import Kingfisher

class DishCollectionViewCell: UICollectionViewCell {
    static let identifier = "DishCollectionViewCell"
    private lazy var imageView : UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    private lazy var foodType : UILabel = {
        var label = UILabel()
        label.numberOfLines = 2;
        label.lineBreakMode = .byWordWrapping
        label.textColor = .myLightGrey
        
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 22.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionAboutFood : UITextView = {
        var textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = .myLightGrey
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 5
        textView.font = UIFont(name: "Gilroy-Regular", size: FontSizes.font14)
        
        
        return textView
        
    }()
    private lazy var price : UILabel = {
        var label = UILabel()
      
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

        contentView.addSubview(purchaseButton)
        
    }
    private func setBackGround(){
        let image = UIImageView(image: UIImage(named: "backForCell"))
        image.frame = contentView.bounds
        image.contentMode = .scaleToFill
        contentView.addSubview(image)
        
        
        
    }
    
    private func setConstraints(){
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 21).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (contentView.frame.width - 40) / 1.5 ).isActive = true
        foodType.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10).isActive = true
        foodType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        foodType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true


        descriptionAboutFood.topAnchor.constraint(equalTo: foodType.bottomAnchor,constant: 5).isActive = true
        
        descriptionAboutFood.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        descriptionAboutFood.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true

        
        price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
        price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -26).isActive = true
        

        
        purchaseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -18).isActive = true
        purchaseButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -26).isActive = true
        purchaseButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    func setCellFields(sectionList : SectionList?){
        if let sectionList = sectionList {
            self.foodType.text = sectionList.foodName
            self.descriptionAboutFood.text = sectionList.foodContent.removingHTMLOccurances
            self.price.genetrateLabel(text: sectionList.formattedPrice, color: .red, font: UIFont(name: "FoglihtenNo06", size: 22))
            
            NetworkManager.shared.setImageFromUrl(url: sectionList.foodImage1, imageView: self.imageView,width: 200,aspectRatio: 1.5)

        }

        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
