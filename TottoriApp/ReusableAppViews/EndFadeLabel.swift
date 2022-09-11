//
//  EndFadeLabel.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.09.22.
//

import Foundation
import UIKit


final class EndFadeLabel: UILabel,TwoDimenIndex {
    var index: Int!
    
    var section: Int!
    
    
    
    
    let IGLayer = InvertedGradientLayer()
    
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
        
        guard let font = self.font, let text = self.text else { return }
        
        let constraintRect = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        if boundingBox.height <= bounds.height {
            
            layer.mask = nil
            
            return
            
        }
        
        layer.mask = IGLayer
        
        
        
        // In case of multiline, add: IGLayer.lineHeight = font.lineHeight
        
        IGLayer.gradWidth = UIScreen.main.bounds.width / 13
        
        IGLayer.frame = bounds
        
        IGLayer.setNeedsDisplay()
        
    }
    
}
