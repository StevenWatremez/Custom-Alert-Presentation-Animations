//
//  AlertViewController.swift
//  CustomAlertStyle
//
//  Created by Steven_WATREMEZ on 18/08/2017.
//  Copyright © 2017 Niji. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction private func didPressOk(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func didPressCancel(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}
