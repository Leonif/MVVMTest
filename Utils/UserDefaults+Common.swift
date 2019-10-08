//
//  UserDefaults+Common.swift
//  Utils
//
//  Created by Nifantyev on 4/27/19.
//  Copyright © 2019 Nifantyev. All rights reserved.
//

import Foundation

public extension UserDefaults {
  subscript<T>(key: String) -> T? {
    get {
      return value(forKey: key) as? T
    }
    set {
      set(newValue, forKey: key)
    }
  }
  
  subscript<T: RawRepresentable>(key: String) -> T? {
    get {
      if let rawValue = value(forKey: key) as? T.RawValue {
        return T(rawValue: rawValue)
      }
      return nil
    }
    set {
      set(newValue?.rawValue, forKey: key)
    }
  }
}
