//
//  ViewController.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // Need to be retain because of transitioningDelegate is weak reference
  private let alertTransition = AlertTransitioningManager()
  private let bottomSheetTransition = BottomSheetTransitioningManager()
  
  @IBAction private func didPressFadeAlert(_ sender: UIButton) {
    self.launchAlert(style: .fade)
  }
  
  @IBAction private func didPressSlideUpAlert(_ sender: UIButton) {
    self.launchAlert(style: .slideUp)
  }
    
  @IBAction private func didPressSlideUpBottomSheet(_ sender: UIButton) {
      self.launchBottomSheet(style: .slideUp)
  }
  
  private func launchAlert(style: AlertTransitioningStyle) {
    if let alertVC = storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController {
      alertVC.modalPresentationStyle = .custom
      self.alertTransition.type = style
      alertVC.transitioningDelegate = self.alertTransition
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  private func launchBottomSheet(style: BottomSheetTransitioningStyle) {
    if let bottomSheetVC = storyboard?.instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController {
      bottomSheetVC.modalPresentationStyle = .custom
      self.bottomSheetTransition.type = style
      bottomSheetVC.transitioningDelegate = self.bottomSheetTransition
      self.present(bottomSheetVC, animated: true, completion: nil)
    }
  }
}
