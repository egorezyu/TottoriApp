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
    
    
    
    
    
    private lazy var devView : DeliveryView = DeliveryView(delegate: self,navigationBar: self.navigationController?.navigationBar)
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
        view.backgroundColor = .gray
        setBackGround()
       
//        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")
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
        let flatAndFloor = (devView.vStackFlatAndFloor.subviews[1] as? CustomTextFieldWithInsets)
        flatAndFloor?.text = userInfo?.floorAndFlat ?? ""
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
//    private func setDelegateForMap(){
//        devView.map.delegate = self
//    }

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
        let flatAndFlor = (devView.vStackFlatAndFloor.subviews[1] as? CustomTextFieldWithInsets)
        
        
        if let name = nameField?.text,let phone = phoneField?.text{
            if (!name.isEmpty && !phone.isEmpty){
                let removeOccPhone = phone.replacingOccurrences(of:"[^0-9]", with: "",options: .regularExpression)
                
                if (removeOccPhone.phoneIsValid()){
    
                    if selectedPayView != nil {
                        devView.makeAnOrderButton.isEnabled = true
                        userInfo = UserInfo(name: name, phone: phone, mail: email?.text ?? "", street: street?.text ?? "", home: home?.text ?? "", floorAndFlat: flatAndFlor?.text ?? "")
                        
                    }
                    else{
                        devView.makeAnOrderButton.isEnabled = false
                        devView.makeAnOrderButton.setTitle("Выберите способ оплаты", for: .disabled)
                    }
                    
                }
                else{
                    devView.makeAnOrderButton.isEnabled = false
                    devView.makeAnOrderButton.setTitle("Введите корректный телефон", for: .disabled)
                }
            }
            else{
                devView.makeAnOrderButton.setTitle("Заполните имя и телефон", for: .disabled)
                devView.makeAnOrderButton.isEnabled = false
            }
            
            
            
        }
    
    }
    
    
    
    
    func switchTextField(sender: UITextField) {
        controlAlgoColor(currentField: sender)
    }
    
    
    
    func postRequest() {
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
                showOkAlert()
            }
            
               
                
          
                
            
            
            
        }
        else{
            UserDefaults.standard.set(encodedData, forKey: userDefaultUserInfoId)
            showOkAlert()
            
        }
        backetViewBackDataDelegate?.clearAllBasket()
        
        
        
       
    }
    private func showChangeAlert(dataToChange : Data){
        let alert = UIAlertController(title: nil, message: "Ваши данные о доставке были изменены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Сохранить текущие данных", style: .default, handler: { action in
            UserDefaults.standard.set(dataToChange, forKey: self.userDefaultUserInfoId)
            self.showOkAlert()
           
        }))
        alert.addAction(UIAlertAction(title: "Не сохранять", style: .default, handler: { action in
            self.showOkAlert()
           
        }))
        present(alert,animated: true)
        
    }

//    func setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D,title : String,subTitle : String){
//       let annotation = MKPointAnnotation()
//       annotation.coordinate = location
//       annotation.title = title
//       annotation.subtitle = subTitle
//       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
//        devView.map.setRegion(coordinateRegion, animated: true)
//        devView.map.addAnnotation(annotation)
//    }
//    
    
}
extension DeliveryViewController : MKMapViewDelegate{
    
}
