//
//  AboutUsView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 9.08.22.
//

import UIKit
import DGCarouselFlowLayout

class AboutUsView: UIView,PhoneFieldProtocol {
    private weak var delegate : AboutUsDelegate?
    init(delegate : AboutUsDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        addViews()
        setConstraints()
        
        
    }
    private lazy var aboutIntLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "наш интерьер"
        label.font = UIFont(name: "Gilroy", size: 14)
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
        label.font = UIFont(name: "FoglihtenNo06", size: 30)
        
        return label
        
    }()
    private lazy var chinaSymbol : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)


   


        view.textAlignment = .center

        view.attributedText = NSMutableAttributedString(string: "レストランインテリア", attributes: [NSAttributedString.Key.kern: 2.8])
        return view
        
    }()
    private lazy var tableOrderLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FoglihtenNo06", size: 30)
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
        view.font = UIFont(name: "Gilroy", size: 14)
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
    public lazy var vStackTime : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "Время")
        var timeField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        timeField?.tag = 3
        timeField?.keyboardType = .numberPad
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
    private lazy var horCollectionView : UICollectionView = {
        var layout = DGCarouselFlowLayout()
        layout.scrollDirection = .horizontal
       
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        
        
        return collectionView
        
        
    }()
    private lazy var aboutUsView : AboutUsData = {
        var data = AboutUsData()
        data.translatesAutoresizingMaskIntoConstraints = false
        return data
        
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
    private func addViews(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(aboutIntLabel)
//        contentView.addSubview(horCollectionView)
        contentView.addSubview(aboutBeatyLabel)
        contentView.addSubview(chinaSymbol)
        contentView.addSubview(tableOrderLabel)
        contentView.addSubview(waitForYouLabel)
        contentView.addSubview(vStackFields)
        contentView.addSubview(aboutUsView)
        contentView.addSubview(vipView)
        contentView.addSubview(makeAnOrderButton)
    }
    private func setConstraints(){
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        aboutIntLabel.centerYAnchor.constraint(equalTo: aboutBeatyLabel.centerYAnchor,constant: -20).isActive = true
        aboutIntLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        
        
        aboutBeatyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        aboutBeatyLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
      
//
        chinaSymbol.centerYAnchor.constraint(equalTo: aboutBeatyLabel.centerYAnchor,constant: 25).isActive = true
        chinaSymbol.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
//
        tableOrderLabel.topAnchor.constraint(equalTo: aboutBeatyLabel.bottomAnchor,constant: 20).isActive = true
        tableOrderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true

        waitForYouLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        waitForYouLabel.centerYAnchor.constraint(equalTo: tableOrderLabel.centerYAnchor,constant: 25).isActive = true
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
        aboutUsView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.2).isActive = true
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
