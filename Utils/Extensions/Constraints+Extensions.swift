//
// Created by Leonid Nifantyev on 2019-06-27.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit

public extension UIView {
  func straightOnSuperView() {
    guard let superview = superview else {
      assertionFailure("superView is not set !!!")
      return
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
      self.topAnchor.constraint(equalTo: superview.topAnchor),
    ])
  }
  
  func straight(on view: UIView, offset: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
      self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset),
      self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset),
      self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset),
    ])
  }
  
  func straightCenterSuperView() {
    guard let superview = superview else {
      assertionFailure("no super view !!!")
      return
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
      self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
    ])
  }
  
  func straightForScrollView() {
    
      guard let scrollView = superview as? UIScrollView else {
        assertionFailure("this view is not scrollView !!!")
        return
      }
    
      self.translatesAutoresizingMaskIntoConstraints = false
  
      let heightConstraint = self.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
      heightConstraint.priority = UILayoutPriority(rawValue: 250)
      
      NSLayoutConstraint.activate([
        self.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
        self.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
        self.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        self.topAnchor.constraint(equalTo: scrollView.topAnchor),
        self.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        heightConstraint
      ])
  }
}
