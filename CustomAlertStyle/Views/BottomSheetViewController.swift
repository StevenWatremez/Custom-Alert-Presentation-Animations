//// 
// BottomSheetViewController.swift
// CustomAlertStyle
// 
// Created by: Steven Watremez on 05/05/2018
// 

import UIKit

final class BottomSheetViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction private func didPressClose(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func didPressSend(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}
