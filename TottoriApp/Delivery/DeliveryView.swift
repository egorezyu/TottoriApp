//
//  DeliveryView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import UIKit
import MapKit

class DeliveryView: UIView {
    public var userDefaultUserInfoId = "userInfo"
    public var userInfo : UserInfo?
    private weak var delegate : DeliveryDelegate?
    private var selectedTextField : UITextField?
    private var selectedPayView : PayView?
    private var navigationBar : UINavigationBar?

    init(delegate : DeliveryDelegate? = nil,navigationBar : UINavigationBar?) {
        super.init(frame: .zero)
        if let data = UserDefaults.standard.data(forKey: userDefaultUserInfoId),
           let decodedData = try? JSONDecoder().decode(UserInfo.self, from: data){
            self.userInfo = decodedData
        }
        self.navigationBar = navigationBar
        self.delegate = delegate
        addView()
        setConstraints()
        addListenersToTypeOfPaymentButton()
        controlButtonStateAlgo()
        
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
        label.font = UIFont(name: "Gilroy-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
        
    }()
    private lazy var makeAnOrderLabel : UILabel = {
        var label = UILabel()
        label.text = "ОФОРМИТЬ ЗАКАЗ"
        label.font = UIFont(name: "FoglihtenNo06", size: 30)
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
    private lazy var vStackTypeOfPay : UIStackView = {
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
        let arrayOfPayments = vStackTypeOfPay.subviews as? [PayView]
        if let array = arrayOfPayments{
//            array[0].drawCircle()
//            selectedPayView = array[0]
            for payment in array {
                payment.rectangleButtonView.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            }
        }
    
    }
    
    private lazy var PayByCardView : PayView = {
        let payView = PayView()
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        payView.setTypeOfPayment(typeOfPaymentString: "КАРТОЙ КУРЬЕРУ")
        return payView
        
    }()
    private lazy var payByCashView : PayView = {
        let payView = PayView()
        payView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.setTypeOfPayment(typeOfPaymentString: "НАЛИЧНЫЕ")
        return payView
    }()
    private lazy var vStackName : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "ВАШЕ ИМЯ")
        var nameField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        nameField?.addTarget(self, action: #selector(textEditing(sender:)), for: .editingChanged)
        nameField?.tag = 1
        nameField?.text = userInfo?.name ?? ""
        
        return stack
        
    }()
    private lazy var vStackPhone : UIStackView = {
    
        var stack = generateStackWithLabelAndField(name: "ТЕЛЕФОН")
        var phoneField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        phoneField?.addTarget(self, action: #selector(textEditing(sender:)), for: .editingChanged)
        phoneField?.tag = 2
        phoneField?.keyboardType = .numberPad
        phoneField?.text = userInfo?.phone ?? ""
        return stack
    }()
    private lazy var vStackEmail : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "ПОЧТА")
        var emailField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        emailField?.text = userInfo?.mail ?? ""
        return stack
        

        
    }()
    private lazy var vStackStreet : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "УЛИЦА")
        var street = (stack.subviews[1] as? CustomTextFieldWithInsets)
        street?.text = userInfo?.street ?? ""
        return stack

        
    }()
    private lazy var vStackHouse : UIStackView = {
        var stack = generateStackWithLabelAndField(name: "ДОМ")
        var house = (stack.subviews[1] as? CustomTextFieldWithInsets)
        house?.text = userInfo?.home ?? ""
        return stack

        
    }()
    private lazy var vStackFlatAndFloor : UIStackView = {
        
        var stack = generateStackWithLabelAndField(name: "КВАРТИРА И ЭТАЖ")
        var flatAndFloor = (stack.subviews[1] as? CustomTextFieldWithInsets)
        flatAndFloor?.text = userInfo?.floorAndFlat ?? ""
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
    public lazy var map : MKMapView = {
        let mapkit = MKMapView()
//        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")
        mapkit.translatesAutoresizingMaskIntoConstraints = false
        return mapkit
        
    }()
    private lazy var infoAboutUs : AboutUsData = {
        let dataView = AboutUsData()
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
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
        contentView.addSubview(map)
        contentView.addSubview(infoAboutUs)
        navigationBar?.addSubview(aboutDeliveryTimeLabel)
        
    }
    private func generateLabel(name : String) -> UILabel{
        let label = UILabel()
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gilroy", size: 14)
        return label
        
    }
    private func generateTextField(hint : String) -> UITextField{
        let textField = CustomTextFieldWithInsets()
        textField.placeholder = hint
        let rectangleView = UIView()
        rectangleView.backgroundColor = .gray
        //add
        textField.addSubview(rectangleView)
        textField.addTarget(self, action: #selector(switchSelectedTextField(sender:)), for: .touchDown)
        //constraints for bottom line
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        rectangleView.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        rectangleView.centerXAnchor.constraint(equalTo: textField.centerXAnchor).isActive = true
        
        return textField
        
    }
    private func generateStackWithLabelAndField(name : String) -> UIStackView{
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 27
        vStack.distribution = .fillEqually
        vStack.addArrangedSubview(generateLabel(name: name))
        vStack.addArrangedSubview(generateTextField(hint: name))
        return vStack
        
    }
    
    private func setConstraints(){
        if let navigationBar = navigationBar{
            aboutDeliveryTimeLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor,constant: 10).isActive = true
            aboutDeliveryTimeLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor,constant: -10).isActive = true
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
        commentTextArea.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.2).isActive = true
//        commentTextArea.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        makeAnOrderButton.topAnchor.constraint(equalTo: commentTextArea.bottomAnchor,constant: 20).isActive = true
        makeAnOrderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        makeAnOrderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        makeAnOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        makeAnOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
        map.topAnchor.constraint(equalTo: makeAnOrderButton.bottomAnchor,constant: 50).isActive = true
        map.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        map.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        map.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3).isActive = true
       
        
        infoAboutUs.topAnchor.constraint(equalTo: map.bottomAnchor,constant: 100).isActive = true
        infoAboutUs.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        infoAboutUs.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        infoAboutUs.heightAnchor.constraint(equalToConstant: 200).isActive = true
        infoAboutUs.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        


        
        
        
        
    }
    @objc func switchSelectedTextField(sender : UITextField){
        if let selectedTextField = selectedTextField {
            sender.subviews[0].backgroundColor = .red
            selectedTextField.subviews[0].backgroundColor = .gray
        }
        else{
            sender.subviews[0].backgroundColor = .red
           
        }
        selectedTextField = sender
        
    }
    @objc func buttonAction(sender : UIButton){
        let arrayOfPayments = vStackTypeOfPay.subviews as? [PayView]
        if let arrayOfPayments = arrayOfPayments{
            let chosenPayView = arrayOfPayments.first { payView in
                payView.rectangleButtonView === sender
            }
            if let chosenPayView = chosenPayView {
                if chosenPayView != selectedPayView{
                    chosenPayView.drawCircle()
                    selectedPayView?.clearCircle()
                }
                selectedPayView = chosenPayView
            }
        }
        controlButtonStateAlgo()
        
        
    }
    @objc func postRequest(sender : UIButton){
        delegate?.postRequest()
        
    }
    @objc func textEditing(sender : UITextField){
        controlButtonStateAlgo()
        
    }
    
    func controlButtonStateAlgo(){
        let nameField = (vStackName.subviews[1] as? CustomTextFieldWithInsets)
        let phoneField = (vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        let email = (vStackEmail.subviews[1] as? CustomTextFieldWithInsets)
        let street = (vStackStreet.subviews[1] as? CustomTextFieldWithInsets)
        let home = (vStackHouse.subviews[1] as? CustomTextFieldWithInsets)
        let flatAndFlor = (vStackFlatAndFloor.subviews[1] as? CustomTextFieldWithInsets)
        
        if let name = nameField?.text,let phone = phoneField?.text{
            if (!name.isEmpty && !phone.isEmpty){
                if (phone == "123"){
                    if selectedPayView != nil {
                        makeAnOrderButton.isEnabled = true
                        userInfo = UserInfo(name: name, phone: phone, mail: email?.text ?? "", street: street?.text ?? "", home: home?.text ?? "", floorAndFlat: flatAndFlor?.text ?? "")
                    }
                    else{
                        makeAnOrderButton.isEnabled = false
                        makeAnOrderButton.setTitle("Выберите способ оплаты", for: .disabled)
                    }
                    
                }
                else{
                    makeAnOrderButton.isEnabled = false
                    makeAnOrderButton.setTitle("Введите корректный телефон", for: .disabled)
                }
            }
            else{
                makeAnOrderButton.setTitle("Заполните имя и телефон", for: .disabled)
                makeAnOrderButton.isEnabled = false
            }
            
            
            
        }
    
    }
                                                      
                                                      
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

