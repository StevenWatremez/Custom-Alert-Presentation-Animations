//
//  ViewController.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // Need to be retain because of transitioningDelegate is weak reference
  private let transition = AlertPresentationManager()
  
  @IBAction private func didPressFadeAlert(_ sender: UIButton) {
    self.launchAlert(style: .fade)
  }
  
  @IBAction private func didPressSlideUpAlert(_ sender: UIButton) {
    self.launchAlert(style: .slideUp)
  }
  
  private func launchAlert(style: AlertTransitioningStyle) {
    if let alertVC = storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController {
      alertVC.modalPresentationStyle = .custom
      self.transition.type = style
      alertVC.transitioningDelegate = self.transition
      self.present(alertVC, animated: true, completion: nil)
    }
  }
}
