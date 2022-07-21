//
//  DishView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit


class DishView: UIView {
    weak var delegate : DishDelegate?
    var sectionList : SectionList?
    init(subscriber : DishDelegate? = nil){
        super.init(frame: .zero)
        self.delegate = subscriber
        addSubview()
        setLayout()
        setFirstChose()
    }
    private var currentChose = 0
    private var arrayOfNumbers : [UILabel] = []
    private lazy var label : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.font = UIFont(name: "FoglihtenNo06", size: 30)
 
        return label
        
    }()
    
    private lazy var foodImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: "gear")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
      
        return image
    }()
    private lazy var hStack : UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 22
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        for i in 0...2{
            var label = UILabel()
            label.font = UIFont(name: "FoglihtenNo06", size: 27.95)
  
            label.text = String(0) + String(i + 1)
            label.textAlignment = .center
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 29
            label.layer.borderColor = UIColor.clear.cgColor
            label.translatesAutoresizingMaskIntoConstraints = false
            
            arrayOfNumbers.append(label)
            
            
            stack.addArrangedSubview(label)
        }
        return stack
    }()
    private lazy var backButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "redBack"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonWasTapped(sender:)), for: .touchUpInside)
        return button
        
    }()
    private lazy var forwardButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "redForward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forwardButtonWasTapped(sender:)), for: .touchUpInside)
        return button
        
    }()
    private lazy var descriptionLabel : UILabel = {
        var label = UILabel()
        label.text = "Описание"
        label.font = UIFont(name: "Gilroy", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
        
    }()
    private lazy var descriptionText : UITextView = {
        var textView = UITextView()
        textView.font = UIFont(name: "Gilroy", size: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.backgroundColor = .clear
       
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return textView
    }()
    
    private lazy var purchaseButton : UIButton = {
        var button = UIButton()
        
        button.setBackgroundImage(UIImage(named: "purchase")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(addToBasket(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    private lazy var holdButtonView : UIView = {
        var view = UIView()
        view.addSubview(purchaseButton)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    public lazy var controlAmountView : FoodCountView = {
        let foodCountView = FoodCountView()
        foodCountView.translatesAutoresizingMaskIntoConstraints = false
        foodCountView.increaseAmountButton.addTarget(self, action: #selector(increase(sender:)), for: .touchUpInside)
        foodCountView.decreaseAmountButton.addTarget(self, action: #selector(decrease(sender:)), for: .touchUpInside)
        return foodCountView
        
    }()
   
    lazy var weightView : WeightView = {
        var view = WeightView()
        view.layer.borderWidth = 1.22
        view.layer.borderColor = UIColor.red.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var priceView : PriceView = {
        var view = PriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.22
        view.layer.borderColor = UIColor.red.cgColor
      
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubview(){
        addSubview(label)
        addSubview(foodImage)
        addSubview(hStack)
        addSubview(backButton)
        addSubview(forwardButton)
        addSubview(descriptionLabel)
        addSubview(descriptionText)
        addSubview(holdButtonView)
        addSubview(controlAmountView)
        addSubview(weightView)
        addSubview(priceView)
        
        
    }
    private func setLayout(){
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        
        
        foodImage.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 5).isActive = true
        foodImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        foodImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
        
        hStack.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 5).isActive = true
        hStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        
//        forwardButton.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 5).isActive = true
        forwardButton.centerYAnchor.constraint(equalTo: hStack.centerYAnchor).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        backButton.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 5).isActive = true
        backButton.centerYAnchor.constraint(equalTo: hStack.centerYAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor,constant: -17).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 10).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3).isActive = true
        descriptionText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
        
        for view in arrayOfNumbers{
            view.widthAnchor.constraint(equalToConstant: 58).isActive = true
            view.heightAnchor.constraint(equalToConstant: 58).isActive = true
        }
        
        priceView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
        priceView.leadingAnchor.constraint(equalTo : leadingAnchor,constant: 20).isActive = true
        priceView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
//        price.centerXAnchor.constraint(equalTo: priceView.centerXAnchor).isActive = true
//        price.centerYAnchor.constraint(equalTo: priceView.centerYAnchor).isActive = true
//        
//        rubleLabel.leadingAnchor.constraint(equalTo: price.trailingAnchor).isActive = true
//        rubleLabel.centerYAnchor.constraint(equalTo: price.centerYAnchor,constant: -9).isActive = true
        
       holdButtonView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
       holdButtonView.leadingAnchor.constraint(equalTo : priceView.trailingAnchor).isActive = true
       holdButtonView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
       holdButtonView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        purchaseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        purchaseButton.centerYAnchor.constraint(equalTo: holdButtonView.centerYAnchor).isActive = true
        purchaseButton.centerXAnchor.constraint(equalTo: holdButtonView.centerXAnchor).isActive = true
    
      
        
       controlAmountView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor,constant: -UIScreen.main.bounds.height * 0.03).isActive = true
       controlAmountView.trailingAnchor.constraint(equalTo : trailingAnchor,constant: -20).isActive = true
       controlAmountView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
       controlAmountView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        weightView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor,constant: -UIScreen.main.bounds.height * 0.03).isActive = true
        weightView.trailingAnchor.constraint(equalTo : controlAmountView.leadingAnchor).isActive = true
        
        weightView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        weightView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        
//        weightLabel.centerXAnchor.constraint(equalTo: weightView.centerXAnchor).isActive = true
//        weightLabel.centerYAnchor.constraint(equalTo: weightView.centerYAnchor).isActive = true
//        
//        gramLabel.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor).isActive = true
//        gramLabel.centerYAnchor.constraint(equalTo: weightView.centerYAnchor,constant: 3).isActive = true
        
//        gramLabel.trailingAnchor.constraint(equalTo: weightLabel.leadingAnchor).isActive = true
//        gramLabel.centerYAnchor.constraint(equalTo: weightLabel.centerYAnchor,constant: 10).isActive = true
//
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func setValues(sectionList : SectionList){
        self.label.text = sectionList.foodName
        

        self.descriptionText.text = sectionList.foodContent.removingHTMLOccurances
        self.priceView.price.text = sectionList.currentPrice
        self.weightView.weightLabel.text = sectionList.currentWeight
        DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: self.foodImage)
        self.sectionList = sectionList
        
       
        
    }
    func setFirstChose(){
        
        arrayOfNumbers[0].layer.borderColor = UIColor.red.cgColor
    }
    @objc func forwardButtonWasTapped(sender : UIButton){
        currentChose = currentChose + 1
        if (currentChose == arrayOfNumbers.count){
            arrayOfNumbers[arrayOfNumbers.count - 1].layer.borderColor = UIColor.clear.cgColor
            arrayOfNumbers[0].layer.borderColor = UIColor.red.cgColor
            currentChose = 0
        }
        else{
            arrayOfNumbers[currentChose].layer.borderColor = UIColor.red.cgColor
            arrayOfNumbers[currentChose - 1].layer.borderColor = UIColor.clear.cgColor
        }
        setImageForBack()
    }
    @objc func backButtonWasTapped(sender : UIButton){
        currentChose = currentChose - 1
        
        if (currentChose == -1){
            arrayOfNumbers[0].layer.borderColor = UIColor.clear.cgColor
            arrayOfNumbers[arrayOfNumbers.count - 1].layer.borderColor = UIColor.red.cgColor
            currentChose = arrayOfNumbers.count - 1
        }
        else{
            arrayOfNumbers[currentChose].layer.borderColor = UIColor.red.cgColor
            arrayOfNumbers[currentChose + 1].layer.borderColor = UIColor.clear.cgColor
        }
        setImageForBack()
        
    }
    private func setImageForBack(){
        if let sectionList = sectionList {
            switch currentChose {
            case 0 :
                DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: self.foodImage)
                
            case 1 :
                if let image = sectionList.foodImage2{
                    DataService.netWork.setImageFromUrl(url: image, imageView: self.foodImage)
                }
                else{
                    foodImage.image = UIImage(named: "tottori")
                }
                
            case 2 :
                if let image = sectionList.foodImage3{
                    DataService.netWork.setImageFromUrl(url: image, imageView: self.foodImage)
                }
                else{
                    foodImage.image = UIImage(named: "tottori")
                }
                
            default:
                return
                
            }
        }
        
    }
    @objc func increase(sender : UIButton){
        delegate?.increaseAmount()
        
    }
    @objc func decrease(sender : UIButton){
        delegate?.decreaseAmount()
        
    }
    @objc func addToBasket(sender : UIButton){
        delegate?.addToBasket()
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
