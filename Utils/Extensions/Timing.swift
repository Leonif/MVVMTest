//
// Created by Leonid Nifantyev on 2019-08-22.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import Foundation

public protocol Timing {}

public extension Timing {
  func startTimer(on seconds: TimeInterval, fireSelector: Selector) -> Timer {
    return Timer
      .scheduledTimer(timeInterval: seconds,
      target: self,
      selector: fireSelector,
      userInfo: .none, repeats: true)
  }
}