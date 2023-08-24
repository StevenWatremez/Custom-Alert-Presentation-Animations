//
//  BottomSheetSlideUpAnimator.swift
//  CustomAlertStyle
//
//  Created by Steven Watremez on 05/05/2018.
//  Copyright © 2018 All rights reserved.
//

import UIKit

class BottomSheetSlideUpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return BottomSheetAnimationConstants.slideUpDuration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//    let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let containerView = transitionContext.containerView
    
    let animationDuration = self.transitionDuration(using: transitionContext)
    
    toViewController?.view.transform = CGAffineTransform(translationX: 0, y: BottomSheetAnimationConstants.translate)
    toViewController?.view.layer.cornerRadius = BottomSheetAnimationConstants.cornerRadius
    toViewController?.view.clipsToBounds = true
    
    let bottomViewRectY = (toViewController?.view.bounds.height ?? 0) - BottomSheetAnimationConstants.bottomViewHeight
    let bottomViewRect = CGRect(x: 0, y: bottomViewRectY, width: toViewController?.view.bounds.width ?? 0, height: BottomSheetAnimationConstants.bottomViewHeight)
    let bottomView = UIView(frame: bottomViewRect)
    bottomView.restorationIdentifier = BottomSheetAnimationConstants.bottomViewRestorationId
    
    if let toView = toViewController?.view {
      containerView.addSubview(bottomView)
      containerView.addSubview(toView)
    }
    
    bottomView.backgroundColor = .white
    bottomView.alpha = 0.0
    
    let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.7) {
      toViewController?.view.transform = .identity
//      fromViewController?.view.transform = CGAffineTransform(translationX: 0, y: 10)
//        .scaledBy(x: 0.98, y: 1) // you can combine multiple animations
    }
    
    animator.addAnimations({
      bottomView.alpha = 1.0
    }, delayFactor: CGFloat(self.transitionDuration(using: transitionContext) * 0.3))
    
    animator.addCompletion { position in
      transitionContext.completeTransition(position == .end)
    }
    
    animator.startAnimation()
  }
}
