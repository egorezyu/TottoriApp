//
//  AboutUsView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 9.08.22.
//

import UIKit
import DGCarouselFlowLayout

class AboutUsView: UIView,PhoneFieldProtocol,ViewWithStack {
    private weak var delegate : AboutUsDelegate?
    init(delegate : AboutUsDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        addViews()
        setConstraints()
        setChoseFirst()
        
        
    }
    
    private lazy var aboutIntLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "наш интерьер"
        label.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        return label
        
    }()
    private lazy var aboutBeatyLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.15
        label.numberOfLines = 0

        label.lineBreakMode = .byWordWrapping


       


        label.attributedText = NSMutableAttributedString(string: "             красота \nв деталях", attributes: [NSAttributedString.Key.kern: 3.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        
        return label
        
    }()
    private lazy var chinaSymbol : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize:  FontSizes.font14)


   


        view.textAlignment = .center

        view.attributedText = NSMutableAttributedString(string: "レストランインテリア", attributes: [NSAttributedString.Key.kern: 2.8])
        return view
        
    }()
    public lazy var hStack : UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 22
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        for i in 0...2{
            var label = UILabel()
            
            label.textColor = .myLightGrey
            
            label.font = UIFont(name: "FoglihtenNo06", size: 27.95)
            
            
  

            label.textAlignment = .center
            
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 24
            label.layer.borderColor = UIColor.clear.cgColor
            label.translatesAutoresizingMaskIntoConstraints = false
            
           
            
            
            stack.addArrangedSubview(label)
        }
        confirmStack(stack: stack, j: 2)
        return stack
        
       
    }()
//    public func confirmStack(stack : UIStackView,j : Int){
//        var dictionary : [Int : Int] = [:]
//        dictionary[0] = j - 2
//        dictionary[1] = j - 1
//        dictionary[2] = j
//        for (key,value) in dictionary{
//            (stack.subviews[key] as! UILabel).text = String(value + 1)
//            
//            
//        }
//       
//        
//    }
    private lazy var tableOrderLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        label.numberOfLines = 0

        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(string: "бронирование \n                    стола", attributes: [NSAttributedString.Key.kern: 3.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
        
    }()
    private lazy var waitForYouLabel : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        view.attributedText = NSMutableAttributedString(string: "ждем вас ежедневно", attributes: [NSAttributedString.Key.kern: 1.96])
        return view
    }()
    private lazy var vStackFields : UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 50
        vStack.distribution = .fillEqually
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(vStackName)
        vStack.addArrangedSubview(vStackPhone)
        vStack.addArrangedSubview(vStackTime)
        

        
        return vStack
        
    }()
    public lazy var vStackName : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "ВАШЕ ИМЯ")
        var nameField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        nameField?.addTarget(self, action: #selector(textEditing(sender:)), for: .editingChanged)
        nameField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        nameField?.tag = 1
        
        
        return stack
        
    }()
    
    public lazy var vStackPhone : UIStackView = {
    
        var stack = generateStackWithLabelAndField(name: "ТЕЛЕФОН")
        var phoneField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        phoneField?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
//        phoneField?.addTarget(self, action: #selector(phoneTapped(sender:)), for: .touchDown)
        phoneField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        phoneField?.addTarget(self, action: #selector(phoneTapped(sender:)), for: .touchDown)
        phoneField?.tag = 2
        phoneField?.keyboardType = .numberPad
        
        return stack
    }()
    public lazy var timePicker : UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(changeDatePicker(sender :)), for: .valueChanged)
        return datePicker
    }()
    public lazy var toolBar : UIToolbar = {
        var tool = UIToolbar.toolbarPiker(mySelect: #selector(dismissToolBar(sender:)))
        return tool
    }()
    public lazy var vStackTime : UIStackView = {
        
        var stack = generateStackWithLabelAndField(name: "Время")
        var timeField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        

        timeField?.tag = 3
        timeField?.inputView = timePicker
        timeField?.inputAccessoryView = toolBar
        timeField?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        timeField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        return stack
        
    }()
    public lazy var vipView : TogleView = {
        var togle = TogleView()
        togle.translatesAutoresizingMaskIntoConstraints = false
        togle.setText(currentText: "VIP")
        togle.rectangleButtonView.addTarget(self, action: #selector(togleButton(sender : )), for: .touchUpInside)
        return togle
        
    }()
    private lazy var scrollView : UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.setContentHuggingPriority(.defaultLow, for: .vertical)
        scroll.delaysContentTouches = false
        scroll.bounces = true
      
        
        return scroll
        
    }()
    private lazy var contentView : UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    lazy var horCollectionView : UICollectionView = {
        var layout = FlowLay()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 10)
        
       
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FurnitureCollectionViewCell.self, forCellWithReuseIdentifier: FurnitureCollectionViewCell.id)
        
        
        return collectionView
        
        
    }()
    private lazy var aboutUsView : AboutUsData = {
        var vc = AboutUsDataViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc.view as! AboutUsData
        
    }()
    public lazy var makeAnOrderButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.22
        button.setTitle("Забронировать", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(postRequest(sender:)), for: .touchUpInside)
        return button
        
    }()
    public func setChoseFirst(){
        hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
    }
    private func addViews(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(aboutIntLabel)
        contentView.addSubview(horCollectionView)
        contentView.addSubview(aboutBeatyLabel)
        contentView.addSubview(chinaSymbol)
        contentView.addSubview(tableOrderLabel)
        contentView.addSubview(waitForYouLabel)
        contentView.addSubview(vStackFields)
        contentView.addSubview(aboutUsView)
        contentView.addSubview(vipView)
        contentView.addSubview(makeAnOrderButton)
        contentView.addSubview(hStack)
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: horCollectionView.bottomAnchor,constant: 10),

            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            hStack.heightAnchor.constraint(equalToConstant: 48)
           

        ])
        
        for view in hStack.subviews{
            view.widthAnchor.constraint(equalToConstant: 48).isActive = true
            view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        aboutIntLabel.centerYAnchor.constraint(equalTo: aboutBeatyLabel.centerYAnchor,constant: -UIScreen.main.bounds.width / 19.8571428571).isActive = true
        aboutIntLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        
        
        aboutBeatyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16).isActive = true
        aboutBeatyLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        
        horCollectionView.topAnchor.constraint(equalTo: aboutBeatyLabel.bottomAnchor,constant: 20).isActive = true
        horCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        horCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        horCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.7).isActive = true
      
//
        chinaSymbol.centerYAnchor.constraint(equalTo: aboutBeatyLabel.centerYAnchor,constant: UIScreen.main.bounds.width / 15.6).isActive = true
        chinaSymbol.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
//
        tableOrderLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 20).isActive = true
        tableOrderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true

        waitForYouLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        waitForYouLabel.centerYAnchor.constraint(equalTo: tableOrderLabel.centerYAnchor,constant: UIScreen.main.bounds.width / 27.8571428571).isActive = true
//
        vStackFields.topAnchor.constraint(equalTo: tableOrderLabel.bottomAnchor,constant: 20).isActive = true
        vStackFields.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        vStackFields.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        vipView.topAnchor.constraint(equalTo: vStackFields.bottomAnchor,constant: 20).isActive = true
        vipView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        vipView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        vipView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        
        makeAnOrderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        makeAnOrderButton.topAnchor.constraint(equalTo: vipView.bottomAnchor,constant: 20).isActive = true
        makeAnOrderButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        makeAnOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true


//
        aboutUsView.topAnchor.constraint(equalTo: makeAnOrderButton.bottomAnchor,constant: 20).isActive = true
        aboutUsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        aboutUsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        aboutUsView.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView()).isActive = true
        aboutUsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
        
//
        


        
    }
    @objc func switchSelectedTextField(sender : UITextField){
        
        delegate?.switchTextField(sender: sender)
    }
    @objc func postRequest(sender : UIButton){
        delegate?.postRequest(sender: sender)
        
    }
    @objc func togleButton(sender : UIButton){
        delegate?.switchTogle(sender: sender)
    }
    @objc func phoneTapped(sender : UITextField){
        delegate?.phoneTextFieldTapped(sender: sender)
    }
    @objc func textEditing(sender : UITextField){
        delegate?.textEditing(sender: sender)
    }
    @objc func changeDatePicker(sender : UIDatePicker){
        delegate?.changeDatePicker(sender: sender)
    }
    @objc func dismissToolBar(sender : UIToolbar){
        delegate?.dismissToolBar(sender: sender)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
