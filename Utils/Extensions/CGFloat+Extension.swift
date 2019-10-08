//
//  CGFloat+Extension.swift
//  NurKZ
//
//  Created by Nifantyev on 2/21/19.
//

import UIKit

public extension CGFloat {
  var int: Int {
    return Int(self)
  }
  
  var float: Float {
    return Float(self)
  }
  
  var double: Double {
    return Double(self)
  }
}

public extension Float {
  var cgFloat: CGFloat {
    return CGFloat(self)
  }
  var string: String {
    return "\(self)"
  }
  
  var double: Double {
    return Double(self)
  }
}
