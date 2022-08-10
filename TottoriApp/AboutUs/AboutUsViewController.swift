//
//  AboutUsViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class AboutUsViewController: UIViewController {
    private lazy var aboutUsView = AboutUsView(delegate: self)
    internal var selectedTextField: UITextField?
    private lazy var isToggled = false
    
    override func loadView() {
        super.loadView()
        self.view = aboutUsView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackkGround()
        controlButtonStateAlgo()

        // Do any additional setup after loading the view.
    }
    func controlButtonStateAlgo(){
        let nameField = (aboutUsView.vStackName.subviews[1] as? CustomTextFieldWithInsets)
        let phoneField = (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        
        
        if let name = nameField?.text,let phone = phoneField?.text,let time = timeField?.text{
            if (!name.isEmpty && !phone.isEmpty && !time.isEmpty){
                let removeOccPhone = phone.replacingOccurrences(of:"[^0-9]", with: "",options: .regularExpression)
                
                if (removeOccPhone.phoneIsValid()){
    
                    
                    aboutUsView.makeAnOrderButton.isEnabled = true
                        
                        
                    
                    
                    
                }
                else{
                    aboutUsView.makeAnOrderButton.isEnabled = false
                    aboutUsView.makeAnOrderButton.setTitle("Введите корректный телефон", for: .disabled)
                }
            }
            else{
                aboutUsView.makeAnOrderButton.setTitle("Заполните все поля", for: .disabled)
                aboutUsView.makeAnOrderButton.isEnabled = false
            }
            
            
            
        }
    
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
extension AboutUsViewController :  TextFieldControlColorProtocol,AboutUsDelegate{
    func dismissToolBar(sender: UIToolbar) {
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        
        timeField?.text = getFormatter().string(from: aboutUsView.timePicker.date)
        aboutUsView.endEditing(true)
        
    }
    
    func changeDatePicker(sender: UIDatePicker) {
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        
        timeField?.text = getFormatter().string(from: sender.date)
    }
    
    
    
    func postRequest(sender: UIButton) {
        self.showOkAlert()
        let nameField = (aboutUsView.vStackName.subviews[1] as? CustomTextFieldWithInsets)
        let phoneField = (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        nameField?.text = ""
        phoneField?.text = ""
        timeField?.text = ""
        aboutUsView.vipView.clearCircle()
        controlButtonStateAlgo()
        
    }
  
    
    
    func switchTogle(sender: UIButton) {

        if isToggled{
            aboutUsView.vipView.clearCircle()
        }
        else{
            aboutUsView.vipView.drawCircle()
        }
        isToggled.toggle()
    }
    func switchTextField(sender: UITextField) {
        controlAlgoColor(currentField: sender)
    }
    func phoneTextFieldTapped(sender : UITextField){
        if sender.text == ""{
            sender.text = "+7"
        }

    }
    func textEditing(sender: UITextField) {
        if sender === (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets){
            aboutUsView.controlPhoneFieldAlgo()
            
        }
        controlButtonStateAlgo()
    }
    private func getFormatter() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    
}
