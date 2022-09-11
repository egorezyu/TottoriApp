//
//  TransitionManager.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.09.22.
//

import Foundation
import UIKit
final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? CatalogViewController,
            let toView = (transitionContext.viewController(forKey: .to) as? DishViewController)?.view as? DishView
        else {
            
            return
        }

        toView.layoutIfNeeded()
     
        
        
       
        let containerView = transitionContext.containerView
        let description = UILabel()
        description.text = NSLocalizedString("description", comment: "")
        description.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        description.textColor = UIColor.myLightGrey
        description.frame = containerView.convert(toView.descriptionLabel.frame, from: toView.mainView)
      
        let textView = UITextView()
        textView.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .right
        textView.backgroundColor = .clear
        textView.textColor = UIColor.myLightGrey
        textView.text = toView.descriptionText.text
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        textView.frame = containerView.convert(toView.descriptionText.frame, from: toView.mainView)
        
        

        
        
        let text = UILabel()
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textColor = UIColor.myLightGrey
        
        text.font = UIFont(name: "FoglihtenNo06", size: FontSizes.font30)
        text.text = toView.label.text
        text.frame = containerView.convert(fromViewController.currentCell.foodType.frame, from: fromViewController.currentCell)
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = fromViewController.currentCell.imageView.contentMode
        image.image = fromViewController.currentCell.imageView.image
        let backView = UIView()
        backView.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        backView.frame = toView.bounds

        image.frame = containerView.convert(fromViewController.currentCell.imageView.frame, from: fromViewController.currentCell.contentView)
        containerView.addSubview(toView)
        
        containerView.addSubview(backView)
        
        
        containerView.addSubview(text)
        // 7


        containerView.addSubview(image)
        containerView.addSubview(description)
        containerView.addSubview(textView)
        
        toView.isHidden = true
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {


            description.frame = containerView.convert(toView.descriptionLabel.frame, from: toView.mainView)
            textView.frame = containerView.convert(toView.descriptionText.frame, from: toView.mainView)
           
            text.frame = containerView.convert(toView.label.frame, from: toView.mainView)
            image.frame = containerView.convert( toView.foodImage.frame, from: toView.mainView)
           
            

            
        }
        
        animator.addCompletion { position in
            toView.isHidden = false
            image.removeFromSuperview()
            backView.removeFromSuperview()
            textView.removeFromSuperview()
            description.removeFromSuperview()
            text.removeFromSuperview()
            transitionContext.completeTransition(position == .end)
        }
        
        animator.startAnimation()
        
        
        
        
    }
}
