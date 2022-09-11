//
//  InvertedGradientLayer.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.09.22.
//

import Foundation
import UIKit




final class InvertedGradientLayer: CALayer {
    
    
    
    public var lineHeight = CGFloat()
    
    public var gradWidth = CGFloat()
    
    
    
    override func draw(in inContext: CGContext) {
        
        
        
        inContext.setFillColor(UIColor.gray.cgColor)
        
        var rect = self.bounds
        
        
        
        // In case of multiline, change to: rect.size.height -= lineHeight
        
        rect.size.height = lineHeight
        
        inContext.fill(rect)
        
        
        
        let colors = [UIColor.lightGray.cgColor, UIColor.lightGray.withAlphaComponent(0.0).cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)!
        
        
        
        let startPoint = CGPoint(x: bounds.maxX - gradWidth, y: 0.0)
        
        let endPoint = CGPoint(x: bounds.maxX, y: 0.0)
        
        
        
        rect.origin.y = rect.size.height - 1
        
        rect.size.height = bounds.height
        
        inContext.addRect(rect)
        
        inContext.clip()
        
        inContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
    }
    
}

