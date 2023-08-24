//// 
// BottomSheetViewController.swift
// CustomAlertStyle
// 
// Created by: Steven Watremez on 05/05/2018
// 

import UIKit

final class BottomSheetViewController: UIViewController {
  
  var interactionController: UIPercentDrivenInteractiveTransition?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .lightGray
    
    let edge = UIScreenEdgePanGestureRecognizer(target: self,
                                                action: #selector(self.handleEdgePan(_:)))
    edge.edges = .left
    self.view.addGestureRecognizer(edge)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.navigationController?.delegate = self
  }
  
  @IBAction private func didPressClose(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func didPressSend(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func handleEdgePan(_ gesture: UIScreenEdgePanGestureRecognizer) {
    let translate = gesture.translation(in: gesture.view)
    let percent = translate.x / gesture.view!.bounds.size.width
    
    switch gesture.state {
    case .began:
      self.interactionController = UIPercentDrivenInteractiveTransition()
      self.navigationController?.popViewController(animated: true)
    case .changed:
      self.interactionController?.update(percent)
    case .ended:
      let velocity = gesture.velocity(in: gesture.view)
      
      if percent > 0.5 || velocity.x > 0 {
        self.interactionController?.finish()
      }
      else {
        self.interactionController?.cancel()
      }
      self.interactionController = nil
    default:
      break
    }
  }
}

extension BottomSheetViewController: UINavigationControllerDelegate {
  
  /* ... */
  
  func navigationController(_ navigationController: UINavigationController,
                            interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      
      return self.interactionController
  }
}
