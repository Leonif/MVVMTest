//
//  UIViewController+ChildViewController.swift
//  NurKZ
//
//

import UIKit

typealias VoidClosure = () -> Void

extension UIViewController {
  func addChildViewControllerFullScreen(_ childViewController: UIViewController) {
    addChild(childViewController)
    childViewController.view.frame = view.bounds
    view.addSubview(childViewController.view)
    childViewController.didMove(toParent: self)
  }
  
  func removeChildViewControllerFullScreen(_ childViewController: UIViewController) {
    childViewController.willMove(toParent: nil)
    childViewController.view.removeFromSuperview()
    childViewController.removeFromParent()
  }
}

extension UIViewController {
  func switchViewController(from sourceViewController: UIViewController,
                            to destinationViewController: UIViewController,
                            duration: TimeInterval = 0.6,
                            animations: VoidClosure? = nil,
                            animationOptions: UIView.AnimationOptions,
                            completion: VoidClosure?) {
    transition(from: sourceViewController,
               to: destinationViewController,
               duration: duration,
               options: animationOptions,
               animations: animations) { (_) in
      completion?()
    }
  }
  
  func customTransformTransition(initialFrame: CGRect,
                                 from sourceViewController: UIViewController,
                                 to destinationViewController: UIViewController,
                                 duration: TimeInterval = 0.33,
                                 completion: VoidClosure? = nil) {
    sourceViewController.willMove(toParent: nil)
    addChild(destinationViewController)
    destinationViewController.view.frame = initialFrame
    
    transition(from: sourceViewController,
               to: destinationViewController,
               duration: duration,
               options: [],
               animations: {
      destinationViewController.view.frame = self.view.bounds
    },
               completion: { _ in
      completion?()
    })
  }
}
