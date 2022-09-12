//
//  DeliveryViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 23.07.22.
//

import UIKit
import MapKit
import SwiftEntryKit

class DeliveryViewController: UIViewController, TextFieldControlColorProtocol  {
    var deliveryArray : [SectionList] = []
    var stringData : String = ""
    
    
    
    
    
    private lazy var devView : DeliveryView = DeliveryView(delegate: self,navigationBar: self.navigationController?.navigationBar)
    private var deliveryViewModel : DeliveryListViewModel = DeliveryListViewModel()
    private var parameters : [String : Any]!
    internal var selectedTextField : UITextField?
    private var selectedPayView : TogleView?
    public var userInfo : UserInfo?
    public var userDefaultUserInfoId = "userInfo"
    var backetViewBackDataDelegate : BasketViewBackDataDelegate?
    override func loadView() {
        self.view = devView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        setBackGround()
        checkUserDefaultsData()
        setUserDefaultsData()
        controlButtonStateAlgo()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    private func setUserDefaultsData(){
        let phoneField = (devView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        phoneField?.text = userInfo?.phone ?? ""
        let nameField = (devView.vStackName.subviews[1] as? CustomTextFieldWithInsets)
        nameField?.text = userInfo?.name ?? ""
        let emailField = (devView.vStackEmail.subviews[1] as? CustomTextFieldWithInsets)
        emailField?.text = userInfo?.mail ?? ""
        let street = (devView.vStackStreet.subviews[1] as? CustomTextFieldWithInsets)
        street?.text = userInfo?.street ?? ""
        let house = (devView.vStackHouse.subviews[1] as? CustomTextFieldWithInsets)
        house?.text = userInfo?.home ?? ""
        let flat = (devView.vStackFlat.subviews[1] as? CustomTextFieldWithInsets)
        flat?.text = userInfo?.flat ?? ""
        let flor = (devView.vStackFlor.subviews[1] as? CustomTextFieldWithInsets)
        flor?.text = userInfo?.floor ?? ""
    }
    private func checkUserDefaultsData(){
        if let data = UserDefaults.standard.data(forKey: userDefaultUserInfoId),
           let decodedData = try? JSONDecoder().decode(UserInfo.self, from: data){
            self.userInfo = decodedData
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        devView.aboutDeliveryTimeLabel.isHidden = true
        showTabBarView()
    }
    
    private func hideTabBar(){
        tabBarController?.tabBar.isHidden = true
    }
    private func showTabBarView(){
        tabBarController?.tabBar.isHidden = false
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension DeliveryViewController : DeliveryDelegate{
    func phoneTextFieldTapped(sender: UITextField) {
        if sender.text == ""{
            sender.text = "+7"
        }
    }
    
    func textEditing(sender: UITextField) {
        if sender === (devView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets){
            devView.controlPhoneFieldAlgo()
            
        }
        controlButtonStateAlgo()
    }
    
    func switchPayment(sender: UIButton) {
        let arrayOfPayments = devView.vStackTypeOfPay.subviews as? [TogleView]
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
    func controlButtonStateAlgo(){
        let nameField = (devView.vStackName.subviews[1] as? CustomTextFieldWithInsets)
        let phoneField = (devView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        let email = (devView.vStackEmail.subviews[1] as? CustomTextFieldWithInsets)
        let street = (devView.vStackStreet.subviews[1] as? CustomTextFieldWithInsets)
        let home = (devView.vStackHouse.subviews[1] as? CustomTextFieldWithInsets)
        let flat = (devView.vStackFlat.subviews[1] as? CustomTextFieldWithInsets)
        let floor = (devView.vStackFlor.subviews[1] as? CustomTextFieldWithInsets)
        
        
        if let name = nameField?.text,let phone = phoneField?.text{
            if (!name.isEmpty && !phone.isEmpty){
                let removeOccPhone = phone.replacingOccurrences(of:"[^0-9]", with: "",options: .regularExpression)
                
                if (removeOccPhone.phoneIsValid()){
                    
                    if selectedPayView != nil {
                        devView.makeAnOrderButton.isEnabled = true
                        userInfo = UserInfo(name: name, phone: phone, mail: email?.text ?? "", street: street?.text ?? "", home: home?.text ?? "", floor: floor?.text ?? "",flat: flat?.text ?? "")
                        
                    }
                    else{
                        devView.makeAnOrderButton.isEnabled = false
                        devView.makeAnOrderButton.setTitle(NSLocalizedString("pay_type", comment: ""), for: .disabled)
                    }
                    
                }
                else{
                    devView.makeAnOrderButton.isEnabled = false
                    devView.makeAnOrderButton.setTitle(NSLocalizedString("valid_phone", comment: ""), for: .disabled)
                }
            }
            else{
                devView.makeAnOrderButton.setTitle((NSLocalizedString("name_phone", comment: "")), for: .disabled)
                devView.makeAnOrderButton.isEnabled = false
            }
            
            
            
        }
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    func switchTextField(sender: UITextField) {
        controlAlgoColor(currentField: sender)
    }
    
    
    
    
    func postRequest() {
        
        view.isUserInteractionEnabled = false
        
        let name = (devView.vStackName.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let phone = (devView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let email = (devView.vStackEmail.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let street = (devView.vStackStreet.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let home = (devView.vStackHouse.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let flat = (devView.vStackFlat.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let floor = (devView.vStackFlor.subviews[1] as? CustomTextFieldWithInsets)?.text ?? ""
        let orderComment = devView.commentTextArea.text ?? ""
        var foodList : [FoodList] = []
        for item in deliveryArray{
            foodList.append(FoodList(foodAmount: item.count, foodID: item.foodID, foodName: item.foodName))
        }
        let order = Order(orderComment: orderComment, phone: phone, flat: flat, paymentMethod: selectedPayView?.text.text ?? "", entrance: "", intercom: "", street: street, foodList: foodList, city: "Москва", floor: floor, email: email, house: home, name: name)
        let encoder = JSONEncoder()
        

        guard let data = (try? encoder.encode(order)) else {
            return
        }
        stringData = String(bytes : data, encoding: .utf8)!
        print(stringData)
        
       

            
        
        
        guard let model = userInfo,
              let encodedData = try? JSONEncoder().encode(model) else {
            return
        }
        if let data = UserDefaults.standard.data(forKey: userDefaultUserInfoId),
           let decodedData = try? JSONDecoder().decode(UserInfo.self, from: data)
            
        {
            if decodedData != model{
                showChangeAlert(dataToChange: encodedData)
            }
            else{
                devView.activityIndicator.startAnimating()
                //                showOkAlert()
                controlUserButtonServerTouchAlgo()
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        else{
            devView.activityIndicator.startAnimating()
            UserDefaults.standard.set(encodedData, forKey: userDefaultUserInfoId)
            controlUserButtonServerTouchAlgo()
            
            
        }
        
        
        
        
        
    }
    private func showChangeAlert(dataToChange : Data){
        let alert = UIAlertController(title: nil, message: NSLocalizedString("data_was_changed", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("save_data", comment: ""), style: .default, handler: { action in
            UserDefaults.standard.set(dataToChange, forKey: self.userDefaultUserInfoId)
            self.devView.activityIndicator.startAnimating()
            self.controlUserButtonServerTouchAlgo()
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("dont_save", comment: ""), style: .default, handler: { action in
            self.devView.activityIndicator.startAnimating()
            self.controlUserButtonServerTouchAlgo()
            
        }))
        present(alert,animated: true)
        
    }
    private func controlUserButtonServerTouchAlgo(){
      
        
        deliveryViewModel.getDelivList(data: stringData) { result in
            DispatchQueue.main.async {
                self.devView.activityIndicator.stopAnimating()
                switch result{
                    
                    
                case .success(_):
                    self.showCustomAlert(text:NSLocalizedString("thx_for_dev", comment: ""))
                    self.backetViewBackDataDelegate?.clearAllBasket()
                    
                case .failure(_):
                    self.showCustomAlert(text:NSLocalizedString("smth_went_wrong", comment: ""))
                    
                }
            }
            
        }
        
    }
    
    
    
    
}

extension DeliveryViewController : MKMapViewDelegate{
    
}
