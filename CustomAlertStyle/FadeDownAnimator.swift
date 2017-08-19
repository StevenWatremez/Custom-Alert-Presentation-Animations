//
//  FadeDownAnimator.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

class FadeDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.1
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let animationDuration = self .transitionDuration(using: transitionContext)
    
    let animator = UIViewPropertyAnimator(duration: animationDuration, curve: .linear) {
      fromViewController?.view.transform = CGAffineTransform(scaleX: AlertAnimationConstants.scale, y: AlertAnimationConstants.scale)
    }
    animator.addCompletion { position in
      if case .end = position {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    }
    animator.startAnimation()
  }
}
