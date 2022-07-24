//
//  DeliveryView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 24.07.22.
//

import UIKit

class DeliveryView: UIView {
    private weak var delegate : DeliveryDelegate?
    private var selectedTextField : UITextField?
    private var selectedPayView : PayView!
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
            array[0].drawCircle()
            selectedPayView = array[0]
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
        return generateStackWithLabelAndField(name: "ВАШЕ ИМЯ")
        
    }()
    private lazy var vStackPhone : UIStackView = {
    
        var stack = generateStackWithLabelAndField(name: "ТЕЛЕФОН")
        var phoneField = (stack.subviews[1] as? CustomTextFieldWithInsets)
        phoneField?.keyboardType = .numberPad
        return stack
    }()
    private lazy var vStackEmail : UIStackView = {
        return generateStackWithLabelAndField(name: "ПОЧТА")

        
    }()
    private lazy var vStackStreet : UIStackView = {
        return generateStackWithLabelAndField(name: "УЛИЦА")

        
    }()
    private lazy var vStackHouse : UIStackView = {
        return generateStackWithLabelAndField(name: "ДОМ")

        
    }()
    private lazy var vStackFlatAndFloor : UIStackView = {
        return generateStackWithLabelAndField(name: "КВАРТИРА И ЭТАЖ")

        
    }()
    
    private func addView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(makeAnOrderLabel)
        contentView.addSubview(vStackFields)
        contentView.addSubview(vStackTypeOfPay)
        navigationBar?.addSubview(aboutDeliveryTimeLabel)
        
    }
    private func generateLabel(name : String) -> UILabel{
        let label = UILabel()
        label.text = name
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
        
//    
        vStackTypeOfPay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
//
        
        
        
        
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
            var chosenPayView = arrayOfPayments.first { payView in
                payView.rectangleButtonView === sender
            }
            if let chosenPayView = chosenPayView {
                if chosenPayView != selectedPayView{
                    chosenPayView.drawCircle()
                    selectedPayView.clearCircle()
                }
                selectedPayView = chosenPayView
            }
        }
        
        
    }
                                                      
                                                      
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

