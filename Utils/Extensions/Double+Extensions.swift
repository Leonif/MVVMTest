//
// Created by Leonid Nifantyev on 2019-06-13.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit

public extension Double {
  var cgFloat: CGFloat {
    return CGFloat(self)
  }
  
  var float: Float {
    return Float(self)
  }
  
  var int64: Int64 {
    return Int64(self)
  }
  
  var timestamp: TimeStamp {
    return TimeStamp(self)
  }
  
  var int: Int {
    return Int(self)
  }
  
  func string(format: String) -> String {
    return String(format: format, self)
  }
  
  func round(digits: Int) -> Double {
    return self.string(format: "%.\(digits)f").double
  }
}