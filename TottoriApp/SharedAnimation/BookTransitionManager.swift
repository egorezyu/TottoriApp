//
//  BookTransitionManager.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.09.22.
//

import Foundation
import UIKit
final class BookTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? BasketViewController,
            let toView = (transitionContext.viewController(forKey: .to) as? DeliveryViewController)?.view as? DeliveryView
        else {
            
            return
        }

        toView.layoutIfNeeded()
        let containerView = transitionContext.containerView
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toView)
     
        
        
       
        
        
        
        
    }
}

