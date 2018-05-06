//
//  PresentationManager.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 All rights reserved.
//

import UIKit

enum BottomSheetTransitioningStyle {
  case slideUp
}

enum BottomSheetAnimationConstants {
  static let bottomViewHeight: CGFloat = 50
  static let scale: CGFloat = 0.1
  static let translate: CGFloat = UIScreen.main.bounds.height
  static let dimmingViewRestorationId: String = "dimmingView"
  static let bottomViewRestorationId: String = "bottomView"
  static let cornerRadius: CGFloat = 10.0
  static let slideUpDuration: TimeInterval = 0.4
  static let slideDownDuration: TimeInterval = 0.3
}

class BottomSheetTransitioningManager: NSObject, UIViewControllerTransitioningDelegate {
  
  var type: BottomSheetTransitioningStyle = .slideUp
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentationController = BottomSheetPresentationController(presentedViewController: presented, presenting: source)
    return presentationController
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    switch self.type {
      case .slideUp: return BottomSheetSlideUpAnimator()
    }
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    switch self.type {
      case .slideUp: return BottomSheetSlideDownAnimator()
    }
  }
}
