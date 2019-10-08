//
//  UIApplication+KVC.swift
//  NurKZ
//
//

import UIKit

extension UIApplication {
  enum KVCKey: String {
    case statusBar
  }
  
  open override func value(forUndefinedKey key: String) -> Any? {
    debugPrint("\(String(describing: self)) is not key-value coding by key: \(key)")
    return nil
  }
  
  func value(forKVCKey KVCKey: KVCKey) -> Any? {
    return value(forKey: KVCKey.rawValue)
  }
}

extension UIApplication {
  var statusBarView: UIView? {
    return value(forKVCKey: .statusBar) as? UIView
  }
}
