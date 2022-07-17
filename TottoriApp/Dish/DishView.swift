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
    public lazy var price : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Gilroy", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.borderWidth = 1.22
        label.layer.borderColor = UIColor.red.cgColor
        return label
    }()
    private lazy var purchaseButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "purchase")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
        
        return button
        
    }()
    public lazy var controlAmountView : FoodCountView = {
        let foodCountView = FoodCountView()
        foodCountView.translatesAutoresizingMaskIntoConstraints = false
        foodCountView.increaseAmountButton.addTarget(self, action: #selector(increase(sender:)), for: .touchUpInside)
        foodCountView.decreaseAmountButton.addTarget(self, action: #selector(decrease(sender:)), for: .touchUpInside)
        return foodCountView
        
    }()
    public lazy var weightLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Gilroy", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.red.cgColor
        return label
        
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
        addSubview(price)
        addSubview(purchaseButton)
        addSubview(controlAmountView)
        addSubview(weightLabel)
        
    }
    private func setLayout(){
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 26).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        
        
        foodImage.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 26).isActive = true
        foodImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        foodImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        hStack.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 34).isActive = true
        hStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        
        forwardButton.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 50).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        backButton.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 50).isActive = true
        backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor,constant: -17).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 30).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: 138).isActive = true
        descriptionText.widthAnchor.constraint(equalToConstant: 246).isActive = true
        
        for view in arrayOfNumbers{
            view.widthAnchor.constraint(equalToConstant: 58).isActive = true
            view.heightAnchor.constraint(equalToConstant: 58).isActive = true
        }
        
        price.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
        price.leadingAnchor.constraint(equalTo : leadingAnchor,constant: 20).isActive = true
        price.widthAnchor.constraint(equalToConstant: 260).isActive = true
        price.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
       purchaseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
       purchaseButton.leadingAnchor.constraint(equalTo : price.trailingAnchor).isActive = true
       purchaseButton.widthAnchor.constraint(equalToConstant: 88).isActive = true
       purchaseButton.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
       controlAmountView.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor,constant: -20).isActive = true
       controlAmountView.trailingAnchor.constraint(equalTo : trailingAnchor,constant: -20).isActive = true
       controlAmountView.widthAnchor.constraint(equalToConstant: 203).isActive = true
       controlAmountView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        weightLabel.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor,constant: -20).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo : controlAmountView.leadingAnchor).isActive = true
        weightLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        weightLabel.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func setValues(sectionList : SectionList){
        self.label.text = sectionList.foodName

        self.descriptionText.text = sectionList.foodContent.removingHTMLOccurances
        self.price.text = sectionList.foodPrice
        self.weightLabel.text = sectionList.foodWeight
        switch currentChose {
        case 0 :
            DataService.netWork.setImageFromUrl(url: sectionList.foodImage1, imageView: self.foodImage)
            
        case 1 :
            if let image = sectionList.foodImage2{
                DataService.netWork.setImageFromUrl(url: image, imageView: self.foodImage)
            }
            
        case 2 :
            if let image = sectionList.foodImage3{
                DataService.netWork.setImageFromUrl(url: image, imageView: self.foodImage)
            }
        default:
            return
            
        }
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
        
    }
    @objc func increase(sender : UIButton){
        delegate?.increaseAmount()
        
    }
    @objc func decrease(sender : UIButton){
        delegate?.decreaseAmount()
        
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
