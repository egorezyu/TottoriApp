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
    
    lazy var image : UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var title : UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 24.375)
        //        title.isUserInteractionEnabled = true
        title.textColor = .myLightGrey
        title.textAlignment = .left
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
        
    }()
    private lazy var underLine : UIView = {
        let underLine = UIView()
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.backgroundColor = .myLightGrey
        return underLine
    }()
    lazy var priceView : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        view.textAlignment = .center
        
        
        return view
    }()
    lazy var purchaseButton : UIButton = {
        var button = UIButton()
        var image = UIImage(named: "purchase")?.withTintColor(.red,renderingMode: .alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return button
        
    }()
    private lazy var vStack : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        
        
        return view
    }()
    private lazy var descriptionLabel : UILabel = {
        var label = UILabel()
        label.text = NSLocalizedString("description", comment: "")
        label.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.myLightGrey
        
        return label
        
    }()
    private lazy var descriptionText : UITextView = {
        var textView = UITextView()
        textView.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.backgroundColor = .clear
        textView.textColor = UIColor.myLightGrey
        textView.textContainer.maximumNumberOfLines = 5
        
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return textView
    }()
    
    
    
    private func addView(){
        
        contentView.addSubview(image)
        contentView.addSubview(title)
        title.addSubview(underLine)
        contentView.addSubview(vStack)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionText)
        vStack.addSubview(priceView)
        vStack.addSubview(purchaseButton)
        
        
        
    }
    private func setConstraints(){
        
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        image.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2.5).isActive = true
        
        title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: vStack.leadingAnchor,constant: -5).isActive = true
        
        underLine.bottomAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        underLine.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        underLine.widthAnchor.constraint(equalToConstant: 68).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        vStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        vStack.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 10).isActive = true
        
        vStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        vStack.widthAnchor.constraint(equalToConstant: 168).isActive = true
        
        priceView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor,constant: 10).isActive = true
        priceView.centerYAnchor.constraint(equalTo: vStack.centerYAnchor).isActive = true
        
        purchaseButton.trailingAnchor.constraint(equalTo: vStack.trailingAnchor,constant: -10).isActive = true
        purchaseButton.centerYAnchor.constraint(equalTo: vStack.centerYAnchor).isActive = true
        purchaseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: vStack.bottomAnchor,constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: vStack.bottomAnchor,constant: 20).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        
        descriptionText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6).isActive = true
        
        
    }
    func configureCell(sectionList : MenuDish?){
        if let sectionList = sectionList {
            
            NetworkManager.shared.setImageFromUrl(url: sectionList.foodImage0, imageView: image,width: 200,aspectRatio: 1.5)
            title.text = sectionList.foodName
            self.priceView.genetrateLabel(text: sectionList.formattedPrice, color: .red, font: UIFont(name: "FoglihtenNo06", size: CGFloat(UIScreen.main.bounds.width / 17.833)))
            self.descriptionText.text = sectionList.foodContent
        }
        
        
        
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
