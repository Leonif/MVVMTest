//
//  UIView+Visibility-IhorNur.swift
//  NurKZ
//
//

import UIKit

enum Space {
  case top
  case bottom
  case leading
  case trailing
  
  func layoutAttribute() -> NSLayoutConstraint.Attribute {
    switch self {
    case .top: return .top
    case .bottom: return .bottom
    case .leading: return .leading
    case .trailing: return .trailing
    }
  }
}

enum Axis {
  case vertical
  case horizontal
}

extension NSLayoutConstraint {
  static private var originalConstantKey  = "originalConstant"
  
  private var originalConstant: CGFloat? {
    get {
      return objc_getAssociatedObject(self,
                                      &NSLayoutConstraint.originalConstantKey) as? CGFloat
    }
    set {
      objc_setAssociatedObject(self,
                               &NSLayoutConstraint.originalConstantKey,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  fileprivate func setGoneConstant() {
    guard originalConstant == nil else { return }
    originalConstant = constant
    constant = 0
  }
  
  fileprivate func setVisibleConstant() {
    guard let originalConstant = originalConstant else { return }
    constant = originalConstant
    self.originalConstant = nil
  }
  
  fileprivate func isAspectRatio() -> Bool {
    return (firstAttribute == .height && secondAttribute == .width)
      || (firstAttribute == .width && secondAttribute == .height)
  }
  
  fileprivate func isHeight() -> Bool {
    return firstAttribute == .height
      && secondAttribute == .notAnAttribute
      && type(of: self) === NSLayoutConstraint.self
  }
  
  fileprivate func isWidth() -> Bool {
    return firstAttribute == .width
      && secondAttribute == .notAnAttribute
      && type(of: self) === NSLayoutConstraint.self
  }
  
  fileprivate func isSpacing(itemView: UIView,
                             attribute: NSLayoutConstraint.Attribute) -> Bool {
    return (firstItem as? UIView == itemView && firstAttribute == attribute)
      || (secondItem as? UIView == itemView && secondAttribute == attribute)
  }
  
  fileprivate func isEqual(itemView: UIView,
                           attribute: NSLayoutConstraint.Attribute) -> Bool {
    return (firstItem as? UIView == itemView && secondItem != nil && firstAttribute == attribute)
      || (secondItem as? UIView == itemView && secondAttribute == attribute)
  }
}

extension UIView {
  static private var isGoneKey  = "isGone"
  static private var aspectRatioConstraintsKey = "aspectRatioConstraints"
  static private var equalHeightConstraintsKey = "equalHeightConstraints"
  static private var equalWidthConstraintsKey = "equalWidthConstraints"
  
  private(set) var isGone: Bool {
    get {
      return (objc_getAssociatedObject(self,
                                       &UIView.isGoneKey) as? Bool) ?? false
    }
    set {
      objc_setAssociatedObject(self,
                               &UIView.isGoneKey,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private var aspectRatioConstraints: [NSLayoutConstraint]? {
    get {
      return objc_getAssociatedObject(self,
                                      &UIView.aspectRatioConstraintsKey) as? [NSLayoutConstraint]
    }
    set {
      objc_setAssociatedObject(self,
                               &UIView.aspectRatioConstraintsKey,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private var equalHeightConstraints: [NSLayoutConstraint]? {
    get {
      return objc_getAssociatedObject(self,
                                      &UIView.equalHeightConstraintsKey) as? [NSLayoutConstraint]
    }
    set {
      objc_setAssociatedObject(self,
                               &UIView.equalHeightConstraintsKey,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private var equalWidthConstraints: [NSLayoutConstraint]? {
    get {
      return objc_getAssociatedObject(self,
                                      &UIView.equalWidthConstraintsKey) as? [NSLayoutConstraint]
    }
    set {
      objc_setAssociatedObject(self,
                               &UIView.equalWidthConstraintsKey,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}

extension UIView {
  func gone(axis: Axis? = nil,
            spaces: [Space]? = nil,
            completion: (() -> ())? = nil) {
    isGone = true
    if axis == .vertical {
      var heightConstraints = findHeightConstraints()
      if heightConstraints == nil {
        heightConstraints = [addHeightConstraint()]
      }
      heightConstraints?.forEach { $0.setGoneConstant() }
    } else if axis == .horizontal {
      var widthConstraints = findWidthConstraints()
      if widthConstraints == nil  {
        widthConstraints = [addWidthConstraint()]
      }
      widthConstraints?.forEach { $0.setGoneConstant() }
    } else {
      var heightConstraints = findHeightConstraints()
      var widthConstraints = findWidthConstraints()
      if widthConstraints == nil && heightConstraints == nil {
        heightConstraints = [addHeightConstraint()]
        widthConstraints = [addWidthConstraint()]
      }
      heightConstraints?.forEach { $0.setGoneConstant() }
      widthConstraints?.forEach { $0.setGoneConstant() }
    }
    
    
    aspectRatioConstraints = findAspectRatioConstraints()
    aspectRatioConstraints?.forEach { $0.isActive = false }
    
    equalWidthConstraints = findEqualConstraints(itemView: self,
                                                 attribute: .width)
    equalWidthConstraints?.forEach { $0.isActive = false }
    
    equalHeightConstraints = findEqualConstraints(itemView: self,
                                                  attribute: .height)
    equalHeightConstraints?.forEach { $0.isActive = false }
    
    spaces?.forEach { goneSpacing( $0.layoutAttribute()) }
    
    setNeedsLayout()
    
    completion?()
  }
  
  func visible(completion: (() -> ())? = nil) {
    guard isGone else { return }
    
    isGone = false
    findHeightConstraints()?.forEach { $0.setVisibleConstant() }
    findWidthConstraints()?.forEach { $0.setVisibleConstant() }
    
    [.top, .bottom, .leading, .trailing].forEach { visibleSpacing($0) }
    
    aspectRatioConstraints?.forEach { $0.isActive = true }
    equalWidthConstraints?.forEach { $0.isActive = true }
    equalHeightConstraints?.forEach { $0.isActive = true }
    
    setNeedsLayout()
    
    completion?()
  }
  
  private func goneSpacing(_ attribute: NSLayoutConstraint.Attribute) {
    guard let spacingConstraints = findSpacingConstraints(itemView: self,
                                                          attribute: attribute) else { return }
    spacingConstraints.forEach { $0.setGoneConstant() }
  }
  
  private func visibleSpacing(_ attribute: NSLayoutConstraint.Attribute) {
    guard let spacingConstraints = findSpacingConstraints(itemView: self,
                                                          attribute: attribute) else { return }
    spacingConstraints.forEach { $0.setVisibleConstant() }
  }
  
  // MARK: - Find Constraints
  private func findHeightConstraints() -> [NSLayoutConstraint]? {
    let heightConstraints = constraints.filter { $0.isHeight() }
    return heightConstraints.count > 0 ? heightConstraints : nil
  }
  
  private func findWidthConstraints() -> [NSLayoutConstraint]? {
    let widthConstraints = constraints.filter { $0.isWidth() }
    return widthConstraints.count > 0 ? widthConstraints : nil
  }
  
  private func findAspectRatioConstraints() -> [NSLayoutConstraint]? {
    return constraints.filter { $0.isAspectRatio() }
  }
  
  private func findSpacingConstraints(itemView: UIView,
                                      attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint]? {
    guard let superview = superview else { return nil }
    let spacingConstraints = superview.constraints
      .filter { $0.isSpacing(itemView: itemView,
                             attribute: attribute) }
    if spacingConstraints.count > 0 {
      return spacingConstraints
    } else {
      return superview.findSpacingConstraints(itemView: itemView,
                                              attribute: attribute)
    }
  }
  
  private func findEqualConstraints(itemView: UIView,
                                    attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint]? {
    guard let superview = superview else { return nil }
    let equalConstraints = superview.constraints
      .filter { $0.isEqual(itemView: itemView,
                           attribute: attribute) }
    if equalConstraints.count > 0 {
      return equalConstraints
    } else {
      return superview.findEqualConstraints(itemView: itemView,
                                            attribute: attribute)
    }
  }
  
  // MARK: - Add Size Constraint
  @discardableResult
  private func addHeightConstraint() -> NSLayoutConstraint {
    return addConstraint(attribute: .height,
                         constant: bounds.size.height)
  }
  
  @discardableResult
  private func addWidthConstraint() -> NSLayoutConstraint {
    return addConstraint(attribute: .width,
                         constant: bounds.size.width)
  }
  
  @discardableResult
  private func addConstraint(attribute: NSLayoutConstraint.Attribute,
                             constant: CGFloat) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: constant)
    constraint.priority = UILayoutPriority(rawValue: 751)
    addConstraint(constraint)
    return constraint
  }
}
