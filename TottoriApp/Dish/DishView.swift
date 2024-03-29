//
//  DishView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

//
//  DishView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 15.07.22.
//

import UIKit


class DishView: UIView {
    weak var delegate : DishDelegate?
    
    init(subscriber : DishDelegate? = nil){
        super.init(frame: .zero)
        self.delegate = subscriber
        addSubview()
        setLayout()
        setFirstChose()
    }
    public var arrayOfNumbers : [UIButton] = []
    lazy var label : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.myLightGrey
        
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        
        return label
        
    }()
    
    public lazy var foodImage : UIImageView = {
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
            var button = UIButton()
            button.addTarget(self, action: #selector(buttonImageAction(sender:)), for: .touchUpInside)
            button.setTitleColor(UIColor.myLightGrey, for: .normal)
            button.tag = i
            button.titleLabel?.font = UIFont(name: "FoglihtenNo06", size: 27.95)
            
            
            
            button.setTitle(String(0) + String(i + 1), for: .normal)
            
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 24
            button.layer.borderColor = UIColor.clear.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            
            arrayOfNumbers.append(button)
            
            
            stack.addArrangedSubview(button)
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
    lazy var descriptionLabel : UILabel = {
        var label = UILabel()
        label.text = NSLocalizedString("description", comment: "")
        label.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.myLightGrey
        
        return label
        
    }()
    lazy var descriptionText : UITextView = {
        var textView = UITextView()
        textView.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.backgroundColor = .clear
        textView.textColor = UIColor.myLightGrey
        
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
    lazy var chevronDown : UIImageView = {
        let image = UIImageView(image: UIImage(named: "chevronL"))
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    public func addChevronToView(){
        addSubview(chevronDown)
        chevronDown.trailingAnchor.constraint(equalTo: weightView.trailingAnchor,constant: -15).isActive = true
        chevronDown.centerYAnchor.constraint(equalTo: weightView.centerYAnchor).isActive = true
        chevronDown.widthAnchor.constraint(equalToConstant: 15).isActive = true
        chevronDown.heightAnchor.constraint(equalToConstant: 9).isActive = true
        
    }
    
    lazy var weightView : UILabel = {
        var view = UILabel()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(popUpButtonWasTapped(sender:)))
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.red.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.myLightGrey
        view.isUserInteractionEnabled = true
        view.textAlignment = .center
        view.addGestureRecognizer(gesture)
        return view
        
    }()
    
    lazy var priceView : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.red.cgColor
        view.textAlignment = .center
        
        
        return view
    }()
    lazy var scrollView : UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.setContentHuggingPriority(.defaultLow, for: .vertical)
        scroll.delaysContentTouches = false
        scroll.bounces = true
        
        
        return scroll
        
    }()
    lazy var mainView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        contentView.addSubview(foodImage)
        contentView.addSubview(hStack)
        contentView.addSubview(backButton)
        contentView.addSubview(forwardButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionText)
        contentView.addSubview(holdButtonView)
        contentView.addSubview(controlAmountView)
        contentView.addSubview(weightView)
        contentView.addSubview(priceView)
        
        
        return contentView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubview(){
        scrollView.addSubview(mainView)
        addSubview(scrollView)
        
        
        
        
        
    }
    private func setLayout(){
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 10).isActive = true
        
        
        
        
        label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20).isActive = true
        
        //
        foodImage.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 5).isActive = true
        foodImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 20).isActive = true
        foodImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) / 1.5).isActive = true
        
        //
        hStack.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 5).isActive = true
        hStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 20).isActive = true
        //
        forwardButton.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 20).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.1).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        backButton.topAnchor.constraint(equalTo: foodImage.bottomAnchor,constant: 20).isActive = true
        backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor,constant: -17).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.1).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 40).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 20).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 40).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20).isActive = true
        
        descriptionText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6).isActive = true
        
        for view in arrayOfNumbers{
            view.widthAnchor.constraint(equalToConstant: 48).isActive = true
            view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        priceView.topAnchor.constraint(equalTo: weightView.bottomAnchor,constant: 20).isActive = true
        priceView.leadingAnchor.constraint(equalTo : mainView.leadingAnchor,constant: 20).isActive = true
        priceView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        priceView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -20).isActive = true
        
        holdButtonView.topAnchor.constraint(equalTo: weightView.bottomAnchor,constant: 20).isActive = true
        holdButtonView.leadingAnchor.constraint(equalTo : priceView.trailingAnchor).isActive = true
        holdButtonView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20).isActive = true
        holdButtonView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        
        purchaseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        purchaseButton.centerYAnchor.constraint(equalTo: holdButtonView.centerYAnchor).isActive = true
        purchaseButton.centerXAnchor.constraint(equalTo: holdButtonView.centerXAnchor).isActive = true
        
        
        controlAmountView.topAnchor.constraint(equalTo: descriptionText.bottomAnchor,constant: 50).isActive = true
        controlAmountView.trailingAnchor.constraint(equalTo : mainView.trailingAnchor,constant: -20).isActive = true
        controlAmountView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
        controlAmountView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        
        weightView.topAnchor.constraint(equalTo: descriptionText.bottomAnchor,constant: 50).isActive = true
        weightView.trailingAnchor.constraint(equalTo : controlAmountView.leadingAnchor).isActive = true
        
        weightView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        weightView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 20).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func setValues(sectionList : SectionList){
        self.label.text = sectionList.foodName
        
        
        self.descriptionText.text = sectionList.foodContent.removingHTMLOccurances
        setPriceWeightNumber(sectionList: sectionList)
        
        
        NetworkManager.shared.setImageFromUrl(url: sectionList.foodImage1, imageView: self.foodImage,width: 200,aspectRatio: 1.5)
        
        
        
        
    }
    func setPriceWeightNumber(sectionList : SectionList){
        self.controlAmountView.countLabel.text = String(sectionList.count)
        self.priceView.genetrateLabel(text: sectionList.formattedPrice , color: .red, font: UIFont(name: "FoglihtenNo06", size: CGFloat(FontSizes.font39)))
        self.weightView.genetrateLabel(text: sectionList.formattedWeight , color: .black, font: UIFont(name: "FoglihtenNo06", size: CGFloat(FontSizes.font39)),secondFont: UIFont(name: "FoglihtenNo06", size: 15))
    }
    
    func setFirstChose(){
        
        arrayOfNumbers[0].layer.borderColor = UIColor.red.cgColor
    }
    @objc func forwardButtonWasTapped(sender : UIButton){
        delegate?.forwardButtonAction()
        
    }
    @objc func backButtonWasTapped(sender : UIButton){
        
        delegate?.backButtonAction()
        
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
    @objc func buttonImageAction(sender : UIButton){
        delegate?.imageButtonTapped(sender: sender)
        
    }
    @objc func popUpButtonWasTapped(sender : UIGestureRecognizer){
        
        delegate?.showPopUpMenu()
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
