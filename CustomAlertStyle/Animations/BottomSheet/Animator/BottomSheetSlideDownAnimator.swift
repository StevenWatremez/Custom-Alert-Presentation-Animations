//// 
// BottomSheetSlideDownAnimator.swift
// CustomAlertStyle
// 
// Created by: Steven Watremez on 05/05/2018
// 

import UIKit

class BottomSheetSlideDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return BottomSheetAnimationConstants.slideDownDuration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let animationDuration = self.transitionDuration(using: transitionContext)
    
    let dimmingView: UIView? = containerView.subviews.filter { (view: UIView) -> Bool in
      return view.restorationIdentifier == BottomSheetAnimationConstants.dimmingViewRestorationId
      }.first
    
    let bottomView: UIView? = containerView.subviews.filter { (view: UIView) -> Bool in
      return view.restorationIdentifier == BottomSheetAnimationConstants.bottomViewRestorationId
      }.first
    bottomView?.removeFromSuperview()
    
    let animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeOut) {
      dimmingView?.alpha = 0.0
      
//      CGAffineTransform(scaleX: <#T##CGFloat#>, y: <#T##CGFloat#>)
      toViewController?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        .scaledBy(x: 1, y: 1) // you can combine multiple animations
      
      fromViewController?.view.transform = CGAffineTransform(translationX: 0, y: BottomSheetAnimationConstants.translate)
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
