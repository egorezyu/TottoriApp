//
//  MapView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 1.09.22.
//

import UIKit
import MapKit




class MapView: UIView, MKMapViewDelegate {
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

    static let restrictedRegionZoomOnSpan = (latitudeDelta: 0.002, longitudeDelta: 0.002)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackGroundColor()
        setBackGround()
        addViews()
        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")
        setDeliveryArea()
//        setOverLay()
        setConstraints()
        
    }
    public lazy var map : MKMapView = {
        let mapkit = MKMapView()
        mapkit.translatesAutoresizingMaskIntoConstraints = false
        mapkit.delegate = self
       
        
        
        return mapkit
        
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addViews(){
        addSubview(map)
        
        
    }
    private func setConstraints(){
        map.topAnchor.constraint(equalTo: topAnchor,constant: 10).isActive = true
        map.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        map.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        map.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
        
    }
    private func setBackGround(){
        let image = UIImageView(image: UIImage(named: "backForCell"))
        image.frame = bounds
        image.contentMode = .scaleToFill
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        
        
    }
    private func setBackGroundColor(){
        if let image = UIImage(named: "back"){
            backgroundColor = UIColor(patternImage: image)
        }
        
    }
    private func setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D,title : String,subTitle : String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subTitle
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1200, longitudinalMeters: 1400)
        map.setRegion(coordinateRegion, animated: true)
        map.addAnnotation(annotation)
     }
//    private func setOverLay(){
//        let LAX = CLLocation(latitude: 55.757131, longitude: 37.628379)
//        let JFK = CLLocation(latitude: 35.628379, longitude: 24)
//
//        var coordinates = [LAX.coordinate, JFK.coordinate]
//        let geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
//
//        map.addOverlay(geodesicPolyline)
//    }
    
    private func setDeliveryArea() {

            

        let polygon = MKPolygon(coordinates: MapView.deliveryAreaCoordinates, count: MapView.deliveryAreaCoordinates.count)

        map.addOverlay(polygon)

        }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

           

        let polygonView = MKPolygonRenderer(overlay: overlay)

        polygonView.fillColor = UIColor(red: 124, green: 252, blue: 0, alpha: 0.3)

        return polygonView

       }
    func mapView(_ ProfileMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            

            guard annotation is MKPointAnnotation else { return nil }

            let identifier = "Annotation"

            let image = UIImage(named: "logo")

            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)

            annotationView.canShowCallout = true

            annotationView.glyphImage = image

            return annotationView

        }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

           

           let pinToZoomOn = view.annotation

           let span = MKCoordinateSpan(latitudeDelta: MapView.restrictedRegionZoomOnSpan.latitudeDelta, longitudeDelta: MapView.restrictedRegionZoomOnSpan.longitudeDelta)

           let region = MKCoordinateRegion(center: pinToZoomOn!.coordinate, span: span)

           mapView.setRegion(region, animated: true)

       }

   

    

    

        

   

    
   

        

      



        


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
