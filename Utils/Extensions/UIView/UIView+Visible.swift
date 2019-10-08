//
// Created by Leonid Nifantyev on 2019-06-13.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit


public extension UIView {
  func isHalphBottomVisible(relativeView: UIView, percent: Double) -> Bool {
    let p: CGPoint = self.convert(self.bounds.origin, to: relativeView)
    
    let top = p.y
    let bottom = top + self.frame.height
    let boundTop = self.frame.height * percent.cgFloat
    let isVisible = bottom > boundTop
    
    return isVisible
  }
  
  func isFullVisible(relativeView: UIView) -> Bool {
    let p: CGPoint = self.convert(self.bounds.origin, to: relativeView)
    let top = p.y
    let bottom = top + self.frame.height
    return (top > 0 && bottom < UIScreen.main.bounds.height)
  }
  
  func isHalphTopVisible(relativeView: UIView, percent: Double) -> Bool {
    let p: CGPoint = self.convert(self.bounds.origin, to: relativeView)
    let top = p.y
    let bottom = top + self.frame.height * percent.cgFloat
    
    let isVisible = top > 0 && bottom < UIScreen.main.bounds.height
    
    return isVisible
  }
}
