//
//  PresentationManager.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

enum AlertTransitioningStyle {
  case fade
  case slideUp
}

enum AlertAnimationConstants {
  static let scale: CGFloat = 0.1
  static let translate: CGFloat = UIScreen.main.bounds.height
  static let dimmingViewRestorationId: String = "dimmingView"
  static let cornerRadius: CGFloat = 10.0
  static let fadeUpDuration: TimeInterval = 0.5
  static let fadeDownDuration: TimeInterval = 0.1
  static let slideUpDuration: TimeInterval = 0.5
  static let slideDownDuration: TimeInterval = 0.3
}

class AlertPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
  
  var type: AlertTransitioningStyle = .fade
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentationController = CustomAlertPresentation(presentedViewController: presented, presenting: source)
    return presentationController
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    switch self.type {
      case .fade: return FadeUpAnimator()
      case .slideUp: return SlideUpAnimator()
    }
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    switch self.type {
      case .fade: return FadeDownAnimator()
      case .slideUp: return SlideDownAnimator()
    }
    
  }
}
