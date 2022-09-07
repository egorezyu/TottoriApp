//
//  DishCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit
import Kingfisher

class DishCollectionViewCell: UICollectionViewCell {
    lazy var constraint = whiteSlide.topAnchor.constraint(equalTo: foodType.bottomAnchor,constant: 20)
    static let identifier = "DishCollectionViewCell"
     lazy var imageView : ImageWithIndexes = {
        var image = ImageWithIndexes(frame: .zero)
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
     lazy var foodType : TextWithIndexes = {
        var label = TextWithIndexes()

        label.textColor = .myLightGrey
        label.isUserInteractionEnabled = true

        
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 22.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var price : UILabel = {
        var label = UILabel()
      
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    lazy var whiteSlide : UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
//        print(frame.size.height / 2)
//        view.frame = CGRect(x: 0, y: frame.size.height / 2, width: frame.size.width - 10, height: 20)
        return view
    }()
    lazy var firstWeight : WeightAndPriceView = {
        let view = WeightAndPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    lazy var secondWeight : WeightAndPriceView = {
        let view = WeightAndPriceView()

        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    

    private lazy var holdButtonView : UIView = {
        var view = UIView()
        view.addSubview(purchaseButton)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    lazy var purchaseButton : ButtonWithIndexes = {
        var button = ButtonWithIndexes()
        
        button.setBackgroundImage(UIImage(named: "purchase")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        

        
        return button
        
    }()
    lazy var foodCountView : FoodCountView = {
        let foodCountView = FoodCountView()
        foodCountView.countLabel.font = UIFont(name: "FoglihtenNo06", size: 20)
        foodCountView.layer.borderColor = UIColor.darkGray.cgColor
        foodCountView.translatesAutoresizingMaskIntoConstraints = false
        return foodCountView
        
    }()
    lazy var detailsView : DetailsView = {
        var view = DetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
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

        contentView.addSubview(holdButtonView)
        contentView.addSubview(whiteSlide)
        contentView.addSubview(firstWeight)
//        contentView.addSubview(secondWeight)
        contentView.addSubview(foodCountView)
        
    }
    private func setBackGround(){
        let image = UIImageView(image: UIImage(named: "backForCell"))
        image.frame = contentView.bounds
        image.contentMode = .scaleToFill
        contentView.addSubview(image)
        
        
        
    }
    func addDetailsView(){
        contentView.addSubview(detailsView)
        
        detailsView.topAnchor.constraint(equalTo: firstWeight.bottomAnchor).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 3).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -3).isActive = true
        detailsView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    func removeDetailsView(){
        detailsView.removeFromSuperview()
    }
    func addSecondWeightAndSetConstraints(sectionList : SectionList?){
        
        contentView.addSubview(secondWeight)
        if let sectionList = sectionList {
            secondWeight.weight.text = sectionList.foodWeight2! + "г."
            secondWeight.price.genetrateLabel(text: (sectionList.foodPrice2 ?? "0") + " ₽", color: .black, font: UIFont(name: "FoglihtenNo06", size: FontSizes.fonFont23))
        }
        
        secondWeight.topAnchor.constraint(equalTo: firstWeight.bottomAnchor).isActive = true
        secondWeight.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 3).isActive = true
        secondWeight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -3).isActive = true
        secondWeight.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    func removeSecondWeight(){
        secondWeight.removeFromSuperview()
    }
    
    private func setConstraints(){
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 21).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (contentView.frame.width - 40) / 1.5 ).isActive = true
        foodType.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10).isActive = true
        foodType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        foodType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true

        constraint.isActive = true
        whiteSlide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 3).isActive = true
        whiteSlide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -3).isActive = true
        whiteSlide.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        firstWeight.topAnchor.constraint(equalTo: foodType.bottomAnchor,constant: 20).isActive = true
        firstWeight.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 3).isActive = true
        firstWeight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -3).isActive = true
        firstWeight.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        holdButtonView.topAnchor.constraint(equalTo: firstWeight.bottomAnchor,constant: 60).isActive = true
        holdButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15).isActive = true
        holdButtonView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        holdButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true


        purchaseButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        purchaseButton.centerYAnchor.constraint(equalTo: holdButtonView.centerYAnchor).isActive = true
        purchaseButton.centerXAnchor.constraint(equalTo: holdButtonView.centerXAnchor).isActive = true
        
        foodCountView.topAnchor.constraint(equalTo: firstWeight.bottomAnchor,constant: 60).isActive = true
        foodCountView.leadingAnchor.constraint(equalTo: holdButtonView.trailingAnchor,constant: 4).isActive = true
        foodCountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        foodCountView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        



    }
    func setCellFields(sectionList : SectionList?){
        if let sectionList = sectionList {
            self.foodType.text = sectionList.foodName
            self.firstWeight.weight.text = sectionList.formattedWeight
            self.firstWeight.price.genetrateLabel(text: sectionList.formattedPrice, color: .red, font: UIFont(name: "FoglihtenNo06", size: FontSizes.fonFont23))
            foodCountView.countLabel.text = String(sectionList.count)
            
            NetworkManager.shared.setImageFromUrl(url: sectionList.foodImage1, imageView: self.imageView,width: 200,aspectRatio: 1.5)

        }

        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
