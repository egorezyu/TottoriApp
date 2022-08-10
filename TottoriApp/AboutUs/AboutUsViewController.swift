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
        let timeField = (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        
        
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
extension AboutUsViewController : AboutUsDelegate , TextFieldControlColorProtocol{
    func postRequest(sender: UIButton) {
        print("hi")
    }
    func switchTextField(sender: UITextField) {
        controlAlgoColor(currentField: sender)
    }
    
    
}
