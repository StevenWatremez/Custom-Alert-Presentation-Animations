//
//  SlideDownAnimator.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

class SlideDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let animationDuration = self .transitionDuration(using: transitionContext)
    
    let animator = UIViewPropertyAnimator(duration: animationDuration, curve: .linear) {
      fromViewController?.view.transform = CGAffineTransform(translationX: 0, y: AlertAnimationConstants.translate)
        //.scaledBy(x: 0.5, y: 0.5) // you can combine multiple animations
        //.concatenating(CGAffineTransform(rotationAngle: 2)) // you can concat multiple animations to obtain a cutsom animation
    }
    animator.addCompletion { position in
      if case .end = position {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    }
    animator.startAnimation()
  }
}
