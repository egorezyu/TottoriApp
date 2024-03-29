//
//  DeliveryView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import UIKit
import MapKit

class DeliveryView: UIView , PhoneFieldProtocol{
    
    
    private weak var delegate : DeliveryDelegate?
    private var aboutUsDataController = AboutUsDataViewController()
    
    
    private var navigationBar : UINavigationBar?
    
    init(delegate : DeliveryDelegate? = nil,navigationBar : UINavigationBar?) {
        super.init(frame: .zero)
        self.navigationBar = navigationBar
        self.delegate = delegate
        addView()
        setConstraints()
        addListenersToTypeOfPaymentButton()
        
        
    }
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
    lazy var aboutDeliveryTimeLabel : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("deliv_hour", comment: "")
        label.font = UIFont(name: "Gilroy-Medium", size: FontSizes.font14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
        
    }()
    private lazy var makeAnOrderLabel : UILabel = {
        var label = UILabel()
        label.text = NSLocalizedString("make_deliv", comment: "")
        label.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .myLightGrey
        return label
    }()
    private lazy var vStackFields : UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 50
        vStack.distribution = .fillEqually
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(vStackName)
        vStack.addArrangedSubview(vStackPhone)
        vStack.addArrangedSubview(vStackEmail)
        vStack.addArrangedSubview(vStackStreet)
        vStack.addArrangedSubview(vStackHouse)
        vStack.addArrangedSubview(vStackFlat)
        vStack.addArrangedSubview(vStackFlor)
        
        
        return vStack
        
    }()
    lazy var vStackTypeOfPay : UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 25
        vStack.distribution = .fillEqually
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(PayByCardView)
        vStack.addArrangedSubview(payByCashView)
        
        
        
        return vStack
        
    }()
    private func addListenersToTypeOfPaymentButton(){
        let arrayOfPayments = vStackTypeOfPay.subviews as? [TogleView]
        if let array = arrayOfPayments{
            for payment in array {
                payment.rectangleButtonView.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            }
        }
        
    }
    
    private lazy var PayByCardView : TogleView = {
        let payView = TogleView()
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        
        payView.setText(currentText: NSLocalizedString("pay_by_card", comment: ""))
        return payView
        
    }()
    public lazy var payByCashView : TogleView = {
        let payView = TogleView()
        payView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.setText(currentText: NSLocalizedString("cash", comment: ""))
        return payView
    }()
    public lazy var vStackName : UIStackView = {
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("name", comment: ""))
        var nameField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        nameField?.addTarget(self, action: #selector(textEditing(sender:)), for: .editingChanged)
        nameField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        nameField?.tag = 1
        
        
        return stack
        
    }()
    public lazy var vStackPhone : UIStackView = {
        
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("phone", comment: ""))
        var phoneField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        phoneField?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        phoneField?.addTarget(self, action: #selector(phoneTapped(sender:)), for: .touchDown)
        phoneField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        phoneField?.tag = 2
        phoneField?.keyboardType = .numberPad
        
        return stack
    }()
    public lazy var vStackEmail : UIStackView = {
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("email", comment: ""))
        var emailField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        emailField?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        emailField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        return stack
        
        
        
    }()
    public lazy var vStackStreet : UIStackView = {
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("street", comment: ""))
        var street = (stack.subviews[1] as? CustomTextFieldWithInsets)
        street?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        street?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        return stack
        
        
    }()
    public lazy var vStackHouse : UIStackView = {
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("house", comment: ""))
        var house = (stack.subviews[1] as? CustomTextFieldWithInsets)
        house?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        house?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        
        return stack
        
        
    }()
    public lazy var vStackFlat : UIStackView = {
        
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("flat", comment: ""))
        var flatAndFloor = (stack.subviews[1] as? CustomTextFieldWithInsets)
        flatAndFloor?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        flatAndFloor?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        return stack
        
        
    }()
    public lazy var vStackFlor : UIStackView = {
        
        var stack = generateStackWithLabelAndField(name: NSLocalizedString("floor", comment: ""))
        var flatAndFloor = (stack.subviews[1] as? CustomTextFieldWithInsets)
        flatAndFloor?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        flatAndFloor?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        return stack
        
        
    }()
    private lazy var commentLabel : UILabel = {
        return generateLabel(name: NSLocalizedString("comment", comment: ""))
    }()
    lazy var commentTextArea : UITextView = {
        let textArea = UITextView()
        textArea.translatesAutoresizingMaskIntoConstraints = false
        textArea.font = UIFont(name: "Gilroy", size: 20)
        textArea.layer.borderWidth = 1
        textArea.layer.borderColor = UIColor.gray.cgColor
        textArea.backgroundColor = .clear
        return textArea
        
    }()
    public lazy var makeAnOrderButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.22
        button.setTitle(NSLocalizedString("make_deliv", comment: ""), for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(postRequest(sender:)), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var infoAboutUs : AboutUsData = {
        var view = aboutUsDataController.view
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view as! AboutUsData
    }()
    public lazy var activityIndicator : UIActivityIndicatorView = {
        var activityInd = UIActivityIndicatorView()
        activityInd.translatesAutoresizingMaskIntoConstraints = false
        
        activityInd.style = .large
        activityInd.color = .red
        activityInd.hidesWhenStopped = true
        return activityInd
    }()
    
    
    
    
    private func addView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(makeAnOrderLabel)
        contentView.addSubview(vStackFields)
        contentView.addSubview(vStackTypeOfPay)
        contentView.addSubview(commentLabel)
        contentView.addSubview(commentTextArea)
        contentView.addSubview(makeAnOrderButton)
        contentView.addSubview(infoAboutUs)
        contentView.addSubview(activityIndicator)
        navigationBar?.addSubview(aboutDeliveryTimeLabel)
        
    }
    
    
    private func setConstraints(){
        if let navigationBar = navigationBar{
            aboutDeliveryTimeLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor,constant: 10).isActive = true
            aboutDeliveryTimeLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor,constant: -20).isActive = true
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
        
        makeAnOrderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        makeAnOrderLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        
        vStackFields.topAnchor.constraint(equalTo: makeAnOrderLabel.bottomAnchor,constant: 20).isActive = true
        vStackFields.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30).isActive = true
        vStackFields.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30).isActive = true
        
        
        vStackTypeOfPay.topAnchor.constraint(equalTo: vStackFields.bottomAnchor,constant: 50).isActive = true
        vStackTypeOfPay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30).isActive = true
        vStackTypeOfPay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30).isActive = true
        
        
        
        
        commentLabel.topAnchor.constraint(equalTo: vStackTypeOfPay.bottomAnchor,constant: 40).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        
        commentTextArea.topAnchor.constraint(equalTo: commentLabel.bottomAnchor,constant: 18).isActive = true
        commentTextArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        commentTextArea.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        commentTextArea.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
        
        makeAnOrderButton.topAnchor.constraint(equalTo: commentTextArea.bottomAnchor,constant: 20).isActive = true
        makeAnOrderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        makeAnOrderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        makeAnOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        activityIndicator.topAnchor.constraint(equalTo: makeAnOrderButton.bottomAnchor,constant: 15).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        
        
        
        infoAboutUs.topAnchor.constraint(equalTo: makeAnOrderButton.bottomAnchor,constant: 100).isActive = true
        
        infoAboutUs.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        infoAboutUs.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        infoAboutUs.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView()).isActive = true
        
        infoAboutUs.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
        
        
        
        
        
        
    }
    @objc func switchSelectedTextField(sender : UITextField){
        
        delegate?.switchTextField(sender: sender)
    }
    @objc func buttonAction(sender : UIButton){
        delegate?.switchPayment(sender: sender)
        
        
    }
    @objc func postRequest(sender : UIButton){
        delegate?.postRequest()
        
    }
    @objc func textEditing(sender : UITextField){
        //check is it phonefield
        delegate?.textEditing(sender: sender)
        
    }
    
    
    @objc func phoneTapped(sender : UITextField){
        delegate?.phoneTextFieldTapped(sender: sender)
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

