//
//  DeliveryViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 23.07.22.
//

import UIKit

class DeliveryViewController: UIViewController {
    
    private lazy var devView : DeliveryView = DeliveryView(delegate: self,navigationBar: self.navigationController?.navigationBar)
    override func loadView() {
        self.view = devView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setBackGround()
        
        

        // Do any additional setup after loading the view.
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
    private func setBackGround(){
        if let image = UIImage(named: "back"){
            view.backgroundColor = UIColor(patternImage: image)
        }
        
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
    func postRequest() {
        guard let model = devView.userInfo,
              let encodedData = try? JSONEncoder().encode(model) else {
            return
        }
        if let data = UserDefaults.standard.data(forKey: devView.userDefaultUserInfoId){
            if data != encodedData{
                showChangeAlert(dataToChange: encodedData)
                
          
                
            }
            else{
                showOkAlert()
            }
            
        }
        else{
            UserDefaults.standard.set(encodedData, forKey: devView.userDefaultUserInfoId)
            
        }
        
        
        
       
    }
    private func showChangeAlert(dataToChange : Data){
        let alert = UIAlertController(title: nil, message: "Ваши данные о доставке были изменены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Сохранить текущие данных", style: .default, handler: { action in
            UserDefaults.standard.set(dataToChange, forKey: self.devView.userDefaultUserInfoId)
            self.showOkAlert()
        }))
        alert.addAction(UIAlertAction(title: "Не сохранять", style: .default, handler: { action in
            self.showOkAlert()
        }))
        present(alert,animated: true)
        
    }
    private func showOkAlert(){
        
        let alertAboutEndOfPostRequest = UIAlertController(title: nil, message: "Заказ уже обрабатывается", preferredStyle: .alert)
        alertAboutEndOfPostRequest.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alertAboutEndOfPostRequest,animated: true)
        
    }
    
    
}
