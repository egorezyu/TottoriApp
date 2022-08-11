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
        label.text = "Доставим за час"
        label.font = UIFont(name: "Gilroy-Medium", size: UIScreen.main.bounds.width / 27.8571428571)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
        
    }()
    private lazy var makeAnOrderLabel : UILabel = {
        var label = UILabel()
        label.text = "ОФОРМИТЬ ЗАКАЗ"
        label.font = UIFont(name: "FoglihtenNo06", size: UIScreen.main.bounds.width / 13)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        vStack.addArrangedSubview(vStackFlatAndFloor)

        
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
//            array[0].drawCircle()
//            selectedPayView = array[0]
            for payment in array {
                payment.rectangleButtonView.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            }
        }
    
    }
    
    private lazy var PayByCardView : TogleView = {
        let payView = TogleView()
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        
        payView.setText(currentText: "КАРТОЙ КУРЬЕРУ")
        return payView
        
    }()
    public lazy var payByCashView : TogleView = {
        let payView = TogleView()
        payView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 9.75).isActive = true
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.setText(currentText: "НАЛИЧНЫЕ")
        return payView
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
        phoneField?.addTarget(self, action: #selector(phoneTapped(sender:)), for: .touchDown)
        phoneField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        phoneField?.tag = 2
        phoneField?.keyboardType = .numberPad
        
        return stack
    }()
    public lazy var vStackEmail : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "ПОЧТА")
        var emailField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        emailField?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        emailField?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
        return stack
        

        
    }()
    public lazy var vStackStreet : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "УЛИЦА")
        var street = (stack.subviews[1] as? CustomTextFieldWithInsets)
        street?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        street?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
       
        return stack

        
    }()
    public lazy var vStackHouse : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "ДОМ")
        var house = (stack.subviews[1] as? CustomTextFieldWithInsets)
        house?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        house?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        
      
        return stack

        
    }()
    public lazy var vStackFlatAndFloor : UIStackView = {
        
        var stack = generateStackWithLabelAndField(name: "КВАРТИРА И ЭТАЖ")
        var flatAndFloor = (stack.subviews[1] as? CustomTextFieldWithInsets)
        flatAndFloor?.addTarget(self, action: #selector(textEditing(sender:)), for: .allEditingEvents)
        flatAndFloor?.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
       
        return stack

        
    }()
    private lazy var commentLabel : UILabel = {
        return generateLabel(name: "КОММЕНТАРИИ")
    }()
    private lazy var commentTextArea : UITextView = {
        let textArea = UITextView()
        textArea.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle("ОФОРМИТЬ ЗАКАЗ", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(postRequest(sender:)), for: .touchUpInside)
        return button
        
    }()
//    public lazy var map : MKMapView = {
//        let mapkit = MKMapView()
////        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")
//        mapkit.translatesAutoresizingMaskIntoConstraints = false
//        mapkit.layer.borderColor = UIColor.gray.cgColor
//        mapkit.layer.borderWidth = 1.22
//        return mapkit
//        
//    }()
    private lazy var infoAboutUs : AboutUsData = {
        let dataView = AboutUsDataViewController()
        dataView.view.translatesAutoresizingMaskIntoConstraints = false
        return dataView.view as! AboutUsData
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
//        contentView.addSubview(map)
        contentView.addSubview(infoAboutUs)
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
//        vStackFields.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -100).isActive = true
        
        vStackTypeOfPay.topAnchor.constraint(equalTo: vStackFields.bottomAnchor,constant: 50).isActive = true
        vStackTypeOfPay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30).isActive = true
        vStackTypeOfPay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30).isActive = true
        
  
//        vStackTypeOfPay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
        commentLabel.topAnchor.constraint(equalTo: vStackTypeOfPay.bottomAnchor,constant: 40).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        
        commentTextArea.topAnchor.constraint(equalTo: commentLabel.bottomAnchor,constant: 18).isActive = true
        commentTextArea.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        commentTextArea.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        commentTextArea.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
//        commentTextArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        makeAnOrderButton.topAnchor.constraint(equalTo: commentTextArea.bottomAnchor,constant: 20).isActive = true
        makeAnOrderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        makeAnOrderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        makeAnOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        makeAnOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
//        map.topAnchor.constraint(equalTo: makeAnOrderButton.bottomAnchor,constant: 50).isActive = true
//        map.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
//        map.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
//        map.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
       
        
        infoAboutUs.topAnchor.constraint(equalTo: makeAnOrderButton.bottomAnchor,constant: 100).isActive = true
//        infoAboutUs.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        infoAboutUs.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        infoAboutUs.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        infoAboutUs.heightAnchor.constraint(equalToConstant: UIView.getHeightOfAboutUsDataView()).isActive = true
//        infoAboutUs.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 200).isActive = true
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

