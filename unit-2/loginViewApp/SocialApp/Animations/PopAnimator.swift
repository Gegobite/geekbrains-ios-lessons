//
//  PopAnimator.swift
//  SocialApp
//
//  Created by Игорь Ершов on 30.10.2020.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
    
        let width = source.view.frame.width
        let height = source.view.frame.height
    
        let initialTranslation = CGAffineTransform(translationX: -width/2 - height/2, y: -width/2)
        let initialRotation = CGAffineTransform(rotationAngle: 90 * .pi/180)
    
        transitionContext.containerView.backgroundColor = .white
    
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = initialRotation.concatenating(initialTranslation)
    
        UIView.animateKeyframes(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.4,
                    animations: {
                        let translation = CGAffineTransform(translationX: width/2 + height/2, y: -width/2)
                        let rotation = CGAffineTransform(rotationAngle: -90 * .pi/180)
                        
                        source.view.transform = rotation.concatenating(translation)
                    })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.2,
                    relativeDuration: 0.4,
                    animations: {
                        let translation = CGAffineTransform(translationX: 0 , y: 0)
                        let rotation = CGAffineTransform(rotationAngle: 0)
                        
                        destination.view.transform = rotation.concatenating(translation)
                    })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.25,
                    relativeDuration: 0.75,
                    animations: {
                        destination.view.transform = .identity
                    })
                                
                                
            }) { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
