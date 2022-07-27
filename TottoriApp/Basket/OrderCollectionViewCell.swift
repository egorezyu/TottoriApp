//
//  OrderCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 17.07.22.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    static let identifier = "OrderCollectionViewId"
    var sectionList : SectionList!
    override init(frame : CGRect){
        super.init(frame: frame)
        setBackGround()
        addSubViewS()
        setConstraints()
        
    }
    private lazy var dishTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FoglihtenNo06", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
       
        label.numberOfLines = 2
        return label
        
        
    }()
    private lazy var price : PriceView = {
        let view = PriceView()
        view.price.font = UIFont(name: "FoglihtenNo06", size: 26)
        view.rubleLabel.font = UIFont.systemFont(ofSize: 13)
       
        view.translatesAutoresizingMaskIntoConstraints = false

       
        
        return view
    }()
    private lazy var weight : WeightView = {
        let view = WeightView()
        view.weightLabel.font = UIFont(name: "Gilroy", size: 22)
        view.gramLabel.font = UIFont(name: "Gilroy", size: 12)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var vStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .equalSpacing
        
        
        
        stack.addArrangedSubview(dishTitle)
        stack.addArrangedSubview(price)
        stack.addArrangedSubview(weight)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var foodImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    public lazy var controlAmountView : FoodCountView = {
        let controlView = FoodCountView()
        controlView.countLabel.font = UIFont(name: "Gilroy", size: 17)
        
        controlView.translatesAutoresizingMaskIntoConstraints = false
        controlView.layer.borderColor = UIColor.clear.cgColor
        return controlView
        
    }()
    public lazy var deleteFoodButton : UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setValues(sectionList : SectionList){
        self.sectionList = sectionList
        self.dishTitle.text = sectionList.foodName
        self.price.price.text = sectionList.formattedPrice
        self.weight.weightLabel.text = sectionList.formattedWeight
        self.controlAmountView.countLabel.text = String(sectionList.count)
        DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: self.foodImage)
        controlAmountView.increaseAmountButton.tag = Int(sectionList.foodID) ?? -1
        controlAmountView.decreaseAmountButton.tag = Int(sectionList.foodID) ?? -1
        if let id =  Int(sectionList.foodID){
            deleteFoodButton.tag = id
        }
        
        
    }
    func setBackGround(){
        let image = UIImageView(image: UIImage(named: "backForBasketCell"))
        image.frame = contentView.bounds
        image.contentMode = .scaleToFill
        contentView.addSubview(image)
        
    }
    func  addSubViewS(){
        
        contentView.addSubview(foodImage)
        
        contentView.addSubview(controlAmountView)
        contentView.addSubview(deleteFoodButton)
        contentView.addSubview(dishTitle)
        contentView.addSubview(price)
        contentView.addSubview(weight)
        
    }
    func setConstraints(){
        
        foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.3 / 1.5).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3).isActive = true
        
        dishTitle.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
        dishTitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4).isActive = true
        dishTitle.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.4).isActive = true
        
        price.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
        price.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        price.trailingAnchor.constraint(equalTo: controlAmountView.leadingAnchor).isActive = true
        
        weight.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
        weight.centerYAnchor.constraint(equalTo: deleteFoodButton.centerYAnchor).isActive = true
        weight.trailingAnchor.constraint(equalTo: controlAmountView.leadingAnchor).isActive = true
       
        
       
        
        controlAmountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        controlAmountView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        controlAmountView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3).isActive = true
        controlAmountView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.1).isActive = true
        
        
        deleteFoodButton.topAnchor.constraint(equalTo: controlAmountView.bottomAnchor,constant: 10).isActive = true
        deleteFoodButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30).isActive = true
        
        
        
    }
}
