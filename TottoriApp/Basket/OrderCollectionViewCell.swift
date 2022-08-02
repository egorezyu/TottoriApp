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
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 22.9411764706)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.myLightGrey
        
       
        label.numberOfLines = 2
        return label
        
        
    }()
    private lazy var price : UILabel = {
        let view = UILabel()
        

       
        view.translatesAutoresizingMaskIntoConstraints = false

       
        
        return view
    }()
    private lazy var weight : UILabel = {
        let view = UILabel()
        view.textColor = UIColor.myLightGrey
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var vStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
//        stack.spacing = (contentView.frame.height) / 4
        
        stack.distribution = .equalSpacing
        
        
        
//        stack.addArrangedSubview(dishTitle)
        stack.addArrangedSubview(price)
        stack.addArrangedSubview(weight)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var foodImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    public lazy var controlAmountView : FoodCountView = {
        let controlView = FoodCountView()
        controlView.countLabel.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 22.8)
        
        controlView.translatesAutoresizingMaskIntoConstraints = false
        controlView.layer.borderColor = UIColor.clear.cgColor
        return controlView
        
    }()
    public lazy var deleteFoodButton : UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 27.8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.myLightGrey, for: .normal)
        
        return button
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setValues(sectionList : SectionList){
        self.sectionList = sectionList
        self.dishTitle.text = sectionList.foodName
        self.price.genetrateLabel(text: sectionList.formattedPrice, color: .red, font: UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 17.7272727273),secondFont: UIFont(name: "Cormorant", size: UIScreen.main.bounds.width / 19.5))
        self.weight.genetrateLabel(text: sectionList.formattedWeight, color: .black, font: UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 27.7272727273),secondFont: UIFont(name: "Gilroy", size: UIScreen.main.bounds.width / 27.7272727273))
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
//        contentView.addSubview(price)
//        contentView.addSubview(weight)
        contentView.addSubview(vStack)
        
        
    }
    func setConstraints(){
        foodImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive  = true
        foodImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10).isActive = true
        
        foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        
        
        foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.35).isActive = true
        
        vStack.topAnchor.constraint(equalTo: dishTitle.bottomAnchor,constant: contentView.frame.height * 0.18).isActive = true
        vStack.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
        
        vStack.trailingAnchor.constraint(equalTo: controlAmountView.leadingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
        dishTitle.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
        dishTitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: (contentView.frame.height - 20 - 3 * 20) / 4).isActive = true
       
//
//        price.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
//        price.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        price.trailingAnchor.constraint(equalTo: controlAmountView.leadingAnchor).isActive = true
//
//        weight.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor,constant: 10).isActive = true
//        weight.centerYAnchor.constraint(equalTo: deleteFoodButton.centerYAnchor).isActive = true
//        weight.trailingAnchor.constraint(equalTo: controlAmountView.leadingAnchor).isActive = true
       
        
       
        
        controlAmountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        controlAmountView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        controlAmountView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.3).isActive = true
        controlAmountView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.1).isActive = true
        
        
        deleteFoodButton.topAnchor.constraint(equalTo: controlAmountView.bottomAnchor,constant: 10).isActive = true
        deleteFoodButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30).isActive = true
        
        
        
    }
    
    
}
