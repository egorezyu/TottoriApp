//
//  MapView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 1.09.22.
//

import UIKit
import MapKit

class MapView: UIView, MKMapViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackGroundColor()
        setBackGround()
        addViews()
        setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D(latitude: 55.757131, longitude: 37.628379), title: "Новая площадь,14", subTitle: "")
        setOverLay()
        setConstraints()
        
    }
    public lazy var map : MKMapView = {
        let mapkit = MKMapView()
        mapkit.translatesAutoresizingMaskIntoConstraints = false
       
        
        
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
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        map.setRegion(coordinateRegion, animated: true)
        map.addAnnotation(annotation)
     }
    private func setOverLay(){
        let LAX = CLLocation(latitude: 55.757131, longitude: 37.628379)
        let JFK = CLLocation(latitude: 35.628379, longitude: 24)

        var coordinates = [LAX.coordinate, JFK.coordinate]
        let geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)

        map.addOverlay(geodesicPolyline)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
