//
//  Int+Extensions.swift
//  NurKZ
//
//  Created by Nifantyev on 2/21/19.
//

import UIKit

public extension Int {
  func percentage(ofTotalValue totalValue: Int) -> Int {
    guard totalValue != 0 else { return 0 }
    return Int((Double(self) / (Double(totalValue)) * 100).rounded())
  }
  
  var int64: Int64 {
    return Int64(self)
  }
  
  var int32: Int32 {
    return Int32(self)
  }
  
  var int16: Int16 {
    return Int16(self)
  }
}

public extension Int {
  var cgFloat: CGFloat {
    return CGFloat(self)
  }
  
  var float: Float {
    return Float(self)
  }
  var string: String {
    return "\(self)"
  }
  var double: Double {
    return Double(self)
  }
  
  var timestamp: TimeStamp {
    return TimeStamp(self)
  }
}

public extension Int16 {
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


public extension Int {
  var zeroFormat: String {
    return 0 < self && self < 10 ? "0\(self)" : "\(self)"
  }
}

public extension Optional where Wrapped == Int {
  var zeroFormat: String {
    guard let int = self else { return "-" }
    return 0 < int && int < 10 ? "0\(int)" : "\(int)"
  }
}