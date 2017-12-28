//
//  FadeAlertPresentation.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

class CustomAlertPresentation: UIPresentationController {
  
  var dimmingView: UIView!
  
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    self.setupDimmingView()
  }
  
  func setupDimmingView() {
    self.dimmingView = UIView(frame: presentingViewController.view.bounds)
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(tapRecognizer:)))
    self.dimmingView.addGestureRecognizer(tapRecognizer)
  }
  
  @objc func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
    presentingViewController.dismiss(animated: true, completion: nil)
  }
  
  override func presentationTransitionWillBegin() {
    guard let containerView = self.containerView else {
      return
    }
    containerView.insertSubview(self.dimmingView, at: 0)
  }
    
  override func containerViewWillLayoutSubviews() {
    guard let containerView = containerView else {
      return
    }
    self.dimmingView.frame = containerView.bounds
    presentedView?.frame = self.frameOfPresentedViewInContainerView
  }
  
  override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    return self.presentedViewController.preferredContentSize
  }
  
  override var frameOfPresentedViewInContainerView: CGRect {
    var presentedViewFrame = CGRect.zero
    
    guard let presentedView = presentedView,
      let containerBounds = containerView?.bounds else {
        return presentedViewFrame
    }
    presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
    presentedViewFrame.origin.x = (presentedView.bounds.width - self.presentedViewController.preferredContentSize.width) / 2
    presentedViewFrame.origin.y = (presentedView.bounds.height - self.presentedViewController.preferredContentSize.height) / 2
    
    return presentedViewFrame
  }
}
