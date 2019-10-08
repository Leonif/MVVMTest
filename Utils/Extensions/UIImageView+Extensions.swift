//
// Created by Leonid Nifantyev on 2019-06-30.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit

public extension UIImageView {
  func tapHandle(target: Any?, selector: Selector) {
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: selector))
  }
}

public extension UIImage {
  static func fromColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()!
    context.setFillColor(color.cgColor)
    context.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return img
  }
}