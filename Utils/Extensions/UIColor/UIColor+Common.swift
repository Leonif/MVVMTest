//
//  UIColor+Common.swift
//  NurKZ
//
//

import UIKit

public extension UIColor {
  convenience init(hex6: UInt32, alpha: CGFloat = 1) {
    let divisor = CGFloat(255)
    let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
    let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
    let blue = CGFloat(hex6 & 0x0000FF) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    if getRed(&r, green: &g, blue: &b, alpha: &a) {
      return (r,g,b,a)
    }
    return (0,0,0,0)
  }
  
  var stringColor: String {
    return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
  }
}


public func hexStringToUIColor (hex:String?) -> UIColor? {
  
  guard let hex = hex else { return .none }
  
  var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
  
  if (cString.hasPrefix("#")) {
    cString.remove(at: cString.startIndex)
  }
  
  if ((cString.count) != 6) {
    return .none
  }
  
  var rgbValue:UInt64 = 0
  Scanner(string: cString).scanHexInt64(&rgbValue)
  
  return UIColor(
    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
  )
}