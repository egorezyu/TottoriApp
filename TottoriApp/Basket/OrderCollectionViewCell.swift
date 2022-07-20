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
    private lazy var price : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FoglihtenNo06", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    private lazy var weight : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gilroy", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var vStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
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
        self.price.text = sectionList.currentPrice
        self.weight.text = sectionList.currentWeight
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
        contentView.addSubview(vStack)
        contentView.addSubview(controlAmountView)
        addSubview(deleteFoodButton)
        
    }
    func setConstraints(){
        
        foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        foodImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        foodImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3).isActive = true
        
       vStack.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
       vStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30).isActive = true
       vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -30).isActive = true
       vStack.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3).isActive = true
        
        controlAmountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        controlAmountView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        controlAmountView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.4).isActive = true
        deleteFoodButton.topAnchor.constraint(equalTo: controlAmountView.bottomAnchor,constant: 10).isActive = true
        deleteFoodButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        
        
        
    }
}
