//
//  UIEdgeInsets+Initializations.swift
//  NurKZ
//
//

import UIKit

protocol UniformKeypathInitializable: ExpressibleByDictionaryLiteral {
  init()
}

extension UniformKeypathInitializable {
  public init(dictionaryLiteral elements: (WritableKeyPath<Self, Value>, Value)...) {
    self.init()
    for (property, value) in elements {
      self[keyPath: property] = value
    }
  }
}

extension UIEdgeInsets: UniformKeypathInitializable {
  public typealias Value = CGFloat
}
