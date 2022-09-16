//
//  BookTransitionManager.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.09.22.
//

import Foundation
import UIKit
func degreeToRadians(degree : CGFloat) -> CGFloat{
    return (degree * CGFloat.pi) / 180
    
}
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
        
        toView.frame.origin.x = UIScreen.main.bounds.width
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        fromViewController.view.layer.transform.m34 = -1 / 500
        toView.layer.transform.m34 = -1 / 500
        toView.setAnchorPoint(CGPoint(x: 0, y: 0.5))
        fromViewController.view.setAnchorPoint(CGPoint(x: 1, y: 0.5))
        
        var translation = CATransform3DIdentity
        translation = CATransform3DTranslate(translation, -UIScreen.main.bounds.width, 0, 0)
        
        
        
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toView)
        
        
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                
                fromViewController.view.layer.transform = CATransform3DRotate(fromViewController.view.layer.transform, -.pi / 6, 0, 1, 0)
                fromViewController.view.layer.transform = CATransform3DTranslate(fromViewController.view.layer.transform, -200, 0, 0)
                toView.layer.transform = CATransform3DTranslate(toView.layer.transform, -200, 0, 0)
                

                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                fromViewController.view.layer.transform = CATransform3DRotate(fromViewController.view.layer.transform, -.pi / 6, 0, 1, 0)
                
                toView.layer.transform = CATransform3DTranslate(toView.layer.transform, -UIScreen.main.bounds.width + 200, 0, 0)
                
                
                //
            }
            
        }) { _ in
            fromViewController.view.transform = .identity
            toView.isHidden = false
            
            toView.transform = .identity
            transitionContext.completeTransition(true)
        }
        
        
        
        
        
        
        
        
    }
}

