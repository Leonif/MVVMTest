import Foundation
import UIKit


public let defaultFont = UIFont.systemFont(ofSize: 15)



public func +(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
  let sumString = NSMutableAttributedString()
  sumString.append(left)
  sumString.append(right)
  
  return sumString
}

public extension NSAttributedString {
  @discardableResult func setTextColor(_ color: UIColor) -> NSAttributedString {
    let mutable = NSMutableAttributedString(attributedString: self)
    mutable.color(color)
    return mutable
  }
  
  @discardableResult func setAlignment(_ alignment: NSTextAlignment) -> NSAttributedString {
    let mutable = NSMutableAttributedString(attributedString: self)
    mutable.align(alignment)
    return mutable
  }
  @discardableResult func setFont(_ font: UIFont) -> NSAttributedString {
    let mutable = NSMutableAttributedString(attributedString: self)
    mutable.setFont(self.string, font: font)
    return mutable
  }
}


public extension NSMutableAttributedString {
  @discardableResult func setFont(_ text: String, font: UIFont = defaultFont) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [
      .font: font
    ]
    let boldString = NSMutableAttributedString(string:text, attributes: attrs)
//    append(boldString)
    
    return boldString
  }
  @discardableResult func bold(_ text: String, color: UIColor, font: UIFont = defaultFont) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: color
    ]
    let boldString = NSMutableAttributedString(string:text, attributes: attrs)
//    append(boldString)
    
    return boldString
  }
  
  @discardableResult func normal(_ text: String, color: UIColor = .black, alignment: NSTextAlignment = .left, font: UIFont = defaultFont) -> NSMutableAttributedString {
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    
    let attrs: [NSAttributedString.Key: Any] = [
      .foregroundColor: color,
      .font: font,
      .paragraphStyle: paragraphStyle
    ]
    let string = NSMutableAttributedString(string:text, attributes: attrs)
    append(string)
    
    return self
  }
  
  @discardableResult func color(_ color: UIColor) -> NSMutableAttributedString {
    let range = (self.string as NSString).range(of: self.string)
    let attrs: [NSAttributedString.Key: Any] = [
      .foregroundColor: color
    ]
    self.addAttributes(attrs, range: range)
    
    return self
  }
  
  @discardableResult func align(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
    let range = (self.string as NSString).range(of: self.string)
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    
    let attrs: [NSAttributedString.Key: Any] = [
      .paragraphStyle: paragraphStyle
    ]
    self.addAttributes(attrs, range: range)
    
    return self
  }
  
  
  @discardableResult func normal(_ text: String, font: UIFont = defaultFont) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [
      .font: font
    ]
    let string = NSMutableAttributedString(string:text, attributes: attrs)
    append(string)
    
    return self
  }
  
  @discardableResult func append(_ text: String, withAttributes attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string:text, attributes: attributes)
    append(attributedString)
    
    return self
  }
}
