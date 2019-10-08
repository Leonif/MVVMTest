//
//  UIAlertAction+KVC.swift
//  NurKZ
//
//

import UIKit

extension UIAlertAction {
  enum KVCKey: String {
    case titleTextColor
  }
  open override func setValue(_ value: Any?,
                              forUndefinedKey key: String) {
    debugPrint("\(String(describing: self)) is not key-value coding by key: \(key)")
  }
}

extension UIAlertAction {
  func setValue(_ value: Any?, forKey key: KVCKey) {
    setValue(value, forKey: key.rawValue)
  }
}
