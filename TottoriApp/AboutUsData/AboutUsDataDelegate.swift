//
//  AboutUsDataDelegate.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.08.22.
//

import Foundation
import MapKit
protocol AboutUsDataDelegate : AnyObject{
    func linkWasTapped(gest : UITapGestureRecognizer)
    func mapButtonWasTapped()
    func unZoom()
    
    
}
