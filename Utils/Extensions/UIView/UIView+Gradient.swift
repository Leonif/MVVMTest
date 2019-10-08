//
// Created by Leonid Nifantyev on 2019-06-15.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit


public extension UIView {
  func gradient(colors: [UIColor]) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.map { $0.cgColor }
    self.layer.addSublayer(gradientLayer)
    gradientLayer.frame = self.bounds
    return gradientLayer
  }
}