//
// Created by Leonid Nifantyev on 2019-05-25.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit

public protocol Tapping {}

public extension Tapping {
  func addTap(to view: UIView, selector: Selector) {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
    tap.cancelsTouchesInView = true
    view.addGestureRecognizer(tap)
  }
}
