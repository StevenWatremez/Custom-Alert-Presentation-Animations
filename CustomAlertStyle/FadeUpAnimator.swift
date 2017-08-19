//
//  FadeUpAnimator.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

class FadeUpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    let containerView = transitionContext.containerView
    
    let animationDuration = self.transitionDuration(using: transitionContext)
    
    toViewController?.view.transform = CGAffineTransform(scaleX: AlertAnimationConstants.scale, y: AlertAnimationConstants.scale)
    toViewController?.view.layer.cornerRadius = 10.0
    toViewController?.view.clipsToBounds = true
    
    if let toView = toViewController?.view {
      containerView.addSubview(toView)
    }
    
    let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.6) {
      toViewController?.view.transform = .identity
    }
    animator.addCompletion { position in
      transitionContext.completeTransition(position == .end)
    }
    animator.startAnimation()
  }
}

