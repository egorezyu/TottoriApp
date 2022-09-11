//
//  AboutUsDataViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.08.22.
//

import UIKit
import MapKit
class AboutUsDataViewController: UIViewController, MKMapViewDelegate {
    private var isShown : Bool = false
    private var isActive : Bool = false
    static let deliveryAreaCoordinates = [
        
        
        CLLocationCoordinate2DMake(55.761104, 37.634060),
        CLLocationCoordinate2DMake(55.758152, 37.638662),
        CLLocationCoordinate2DMake(55.754240, 37.636988),
        CLLocationCoordinate2DMake(55.751739, 37.633028),
        CLLocationCoordinate2DMake(55.751714, 37.624245),
        CLLocationCoordinate2DMake(55.755520, 37.618663),
        
        
        
    ]
    static let restrictedRegion = CLLocationCoordinate2DMake(55.757131, 37.628379)
    
    static let restrictedRegionSpan = (latitudeDelta: 0.16, longitudeDelta: 0.16)
    
    //    static let restrictedRegionZoomOnSpan = (latitudeDelta: 0.002, longitudeDelta: 0.002)
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
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1200)
        aboutUsDataView.map.setRegion(coordinateRegion, animated: true)
        aboutUsDataView.map.addAnnotation(annotation)
    }
    private func setDeliveryArea() {
        
        
        
        let polygon = MKPolygon(coordinates: MapView.deliveryAreaCoordinates, count: MapView.deliveryAreaCoordinates.count)
        
        aboutUsDataView.map.addOverlay(polygon)
        
    }
    private func removeDeliveryArea()
    {
        aboutUsDataView.map.removeOverlays(aboutUsDataView.map.overlays)
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        
        let polygonView = MKPolygonRenderer(overlay: overlay)
        
        polygonView.fillColor = UIColor(red: 124, green: 252, blue: 0, alpha: 0.3)
        
        return polygonView
        
    }
    func mapView(_ ProfileMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        
        let image = UIImage(named: "logoCut")
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        annotationView.canShowCallout = true
        
        annotationView.glyphImage = image
        
        return annotationView
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        
        
        let pinToZoomOn = view.annotation
        
        let span = MKCoordinateSpan(latitudeDelta: MapView.restrictedRegionZoomOnSpan.latitudeDelta, longitudeDelta: MapView.restrictedRegionZoomOnSpan.longitudeDelta)
        let region = MKCoordinateRegion(center: pinToZoomOn!.coordinate,span: span)
        
        
        
        mapView.setRegion(region, animated: true)
        
        
        
        
        
        
        
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
    func unZoom() {
        let region = MKCoordinateRegion(center: AboutUsDataViewController.restrictedRegion, latitudinalMeters: 1000, longitudinalMeters: 1200)
        
        
        
        aboutUsDataView.map.setRegion(region, animated: true)
    }
    
    func mapButtonWasTapped() {
        if isShown{
            aboutUsDataView.deliverZone.setTitle(NSLocalizedString("delivery_zone", comment: ""), for: .normal)
            
            
            
            
            
            removeDeliveryArea()
            
            isShown = false
        }
        else{
            
            aboutUsDataView.deliverZone.setTitle(NSLocalizedString("close_zone", comment: ""), for: .normal)
            
            
            
            
            setDeliveryArea()
            isShown = true
            
        }
        
        
        
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
