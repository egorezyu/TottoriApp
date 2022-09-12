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
        var transform1 = CATransform3DIdentity
        transform1.m34 = -1 / 500
        transform1 = CATransform3DRotate(transform1, -.pi / 4, 0, 1, 0)
        transform1 = CATransform3DTranslate(transform1, -300, 0, 0)
        var transform2 = CATransform3DIdentity
        transform2.m34 = -1 / 500
//        transform2 = CATransform3DRotate(transform2, -.pi / 6, 0, 1, 0)
        transform2 = CATransform3DTranslate(transform2, -300, 0, 0)
        var transform3 = CATransform3DIdentity
        transform3 = CATransform3DTranslate(transform3, -UIScreen.main.bounds.width, 0, 0)
        var transform4 = CATransform3DIdentity
        transform4 = CATransform3DRotate(transform4, .pi / 2, 0, 1, 0)
        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        toView.layer.transform = transform4

      
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toView)
        

        UIView.animateKeyframes(withDuration: duration, delay: 0, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8) {
                fromViewController.view.layer.transform = transform1
                toView.layer.transform = transform2
                
      
          }

          UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
              toView.layer.transform = transform3
              fromViewController.view.layer.transform = transform3
//
          }

        }) { _ in
            fromViewController.view.transform = .identity
//            toView.isHidden = false
            toView.transform = .identity
            transitionContext.completeTransition(true)
        }
       
        
        
       
        
        
        
        
    }
}

