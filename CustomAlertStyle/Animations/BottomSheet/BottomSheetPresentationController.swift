//
//  FadeAlertPresentation.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 All rights reserved.
//

import UIKit

class BottomSheetPresentationController: UIPresentationController {
  
  var dimmingView: UIView!
  
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    self.setupDimmingView()
  }
  
  func setupDimmingView() {
    self.dimmingView = UIView(frame: presentingViewController.view.bounds)
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(tapRecognizer:)))
    self.dimmingView.addGestureRecognizer(tapRecognizer)
    self.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
  }
  
  @objc func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
    presentingViewController.dismiss(animated: true, completion: nil)
  }
  
  override func presentationTransitionWillBegin() {
    guard let containerView = self.containerView else {
      return
    }
    self.dimmingView.frame = containerView.bounds
    self.dimmingView.alpha = 0.0
    
    containerView.insertSubview(self.dimmingView, at: 0)
    UIViewPropertyAnimator(duration: 0, curve: .linear) {
      self.dimmingView.alpha = 1.0
    }.startAnimation()
  }
  
  override func dismissalTransitionWillBegin() {
    UIViewPropertyAnimator(duration: 0, curve: .easeOut) {
      self.dimmingView.alpha = 0.0
    }.startAnimation()
  }
  
  override func containerViewWillLayoutSubviews() {
    guard let containerView = containerView else {
      return
    }
    self.dimmingView.frame = containerView.bounds
    presentedView?.frame = self.frameOfPresentedViewInContainerView
  }
  
  override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: self.presentedViewController.preferredContentSize.height)
  }
  
  override var frameOfPresentedViewInContainerView: CGRect {
    var presentedViewFrame = CGRect.zero
    
    guard let presentedView = presentedView,
      let containerBounds = containerView?.bounds else {
        return presentedViewFrame
    }
    let presentedViewFrameSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
    presentedViewFrame.size = presentedViewFrameSize
    presentedViewFrame.origin.x = (presentedView.bounds.width - presentedViewFrameSize.width) / 2
    presentedViewFrame.origin.y = (presentedView.bounds.height - presentedViewFrameSize.height)
    
    return presentedViewFrame
  }
}
