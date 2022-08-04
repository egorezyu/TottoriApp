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
    private lazy var title : UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 24.375)
        title.textColor = .myLightGrey
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
        if let unImage = image{
            image = UIImage.resizeImage(image: unImage, targetSize: CGSize(width: 40, height: 40))
        }
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return button
        
    }()
    private lazy var vStack : UIStackView = {
        let view = UIStackView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
//        view.distribution = .equalSpacing
        var insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.layoutMargins = insets
        view.isLayoutMarginsRelativeArrangement = true
        
        view.spacing = 40
        view.addArrangedSubview(priceView)
        view.addArrangedSubview(purchaseButton)
        return view
    }()
    private lazy var descriptionLabel : UILabel = {
        var label = UILabel()
        label.text = "Описание"
        label.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 27.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.myLightGrey

        return label
        
    }()
    private lazy var descriptionText : UITextView = {
        var textView = UITextView()
        textView.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 27.8)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.backgroundColor = .clear
        textView.textColor = UIColor.myLightGrey
        
       
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return textView
    }()
    
    
    
    private func addView(){
        contentView.addSubview(label)
        contentView.addSubview(image)
        contentView.addSubview(title)
        title.addSubview(underLine)
        contentView.addSubview(vStack)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionText)
        
        
        
    }
    private func setConstraints(){
        label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        image.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 20).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 40).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40).isActive = true
        image.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3).isActive = true
        
        title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        underLine.bottomAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        underLine.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        underLine.widthAnchor.constraint(equalToConstant: 68).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        vStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        vStack.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 10).isActive = true
        
        vStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: vStack.bottomAnchor,constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
//
        descriptionText.topAnchor.constraint(equalTo: vStack.bottomAnchor,constant: 20).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
//        descriptionText.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3).isActive = true
        descriptionText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6).isActive = true
//        descriptionText.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    func configureCell(sectionList : SectionList?){
        if let sectionList = sectionList {
            
            DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: image)
            title.text = sectionList.foodName
            self.priceView.genetrateLabel(text: sectionList.formattedPrice, color: .red, font: UIFont(name: "FoglihtenNo06", size: CGFloat(UIScreen.main.bounds.width / 17.833)))
            self.descriptionText.text = sectionList.foodContent
        }
        
        
        
        
        
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}