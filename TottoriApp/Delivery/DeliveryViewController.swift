//
//  DeliveryViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 23.07.22.
//

import UIKit
import MapKit

class DeliveryViewController: UIViewController {
    
    private lazy var devView : DeliveryView = DeliveryView(delegate: self,navigationBar: self.navigationController?.navigationBar)
    var backetViewBackDataDelegate : BasketViewBackDataDelegate?
    override func loadView() {
        self.view = devView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setBackGround()
        setDelegateForMap()
        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")
        
        
        
        

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
    private func setDelegateForMap(){
        devView.map.delegate = self
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
        if let data = UserDefaults.standard.data(forKey: devView.userDefaultUserInfoId),
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
            UserDefaults.standard.set(encodedData, forKey: devView.userDefaultUserInfoId)
            showOkAlert()
            
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
        alertAboutEndOfPostRequest.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
            self.backetViewBackDataDelegate?.clearAllBasket()
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alertAboutEndOfPostRequest,animated: true)
        
    }
    func setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D,title : String,subTitle : String){
       let annotation = MKPointAnnotation()
       annotation.coordinate = location
       annotation.title = title
       annotation.subtitle = subTitle
       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        devView.map.setRegion(coordinateRegion, animated: true)
        devView.map.addAnnotation(annotation)
    }
    
    
}
extension DeliveryViewController : MKMapViewDelegate{
    
}
