//
//  AboutUsDataViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.08.22.
//

import UIKit
import MapKit
class AboutUsDataViewController: UIViewController, MKMapViewDelegate {
    private lazy var aboutUsDataView = AboutUsData(delegate: self)
    override func loadView() {
        super.loadView()
        self.view = aboutUsDataView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegateForMap()
        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")

        // Do any additional setup after loading the view.
    }
    private func setDelegateForMap(){
        aboutUsDataView.map.delegate = self
    }
    func setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D,title : String,subTitle : String){
       let annotation = MKPointAnnotation()
       annotation.coordinate = location
       annotation.title = title
       annotation.subtitle = subTitle
       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
       aboutUsDataView.map.setRegion(coordinateRegion, animated: true)
       aboutUsDataView.map.addAnnotation(annotation)
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
extension AboutUsDataViewController : AboutUsDataDelegate{
    func mapButtonWasTapped() {
        showMapView()
    }
    
    func linkWasTapped(gest: UITapGestureRecognizer) {
        
        let number = "+74996780886"
        
        guard let number = URL(string: "tel://" + number) else { return }
              if UIApplication.shared.canOpenURL(number) {
                  UIApplication.shared.open(number)
              } else {
                  present(UIAlertController.createAllert(text: "Невозможно открыть телефон"),animated: true)
              }

    }
    
   
    
    
}
