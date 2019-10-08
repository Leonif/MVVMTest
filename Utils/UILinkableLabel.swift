//
//  UILinkedLabel.swift
//  Tele2
//
//  Created by l.nifantyev on 10/10/18.
//  Copyright © 2018 Tele2. All rights reserved.
//

import Foundation
import UIKit

public class UILinkedLabel: UIView, UITextViewDelegate {
  
  public var onClick: ((URL) -> Void)? = nil
  public var attributedText: NSAttributedString? {
    didSet {
      textView?.attributedText = attributedText
    }
  }
  
  public var font: UIFont? {
    didSet {
      textView?.attributedText = textView?.attributedText.setFont(font!)
    }
  }
  
  public var color: UIColor? {
    didSet {
      textView?.attributedText = textView?.attributedText.setTextColor(color!)
    }
  }
  
  public var alignment: NSTextAlignment? {
    didSet {
      textView?.attributedText = textView?.attributedText.setAlignment(alignment!)
    }
  }
  
  
  var textView: UITextView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  override public var backgroundColor: UIColor? {
    didSet { textView?.backgroundColor = backgroundColor }
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    guard let textView = textView else { return }
    self.addSubview(textView)
    textView.fillSuperview()
    
    if #available(iOS 10.0, *) {
      textView.adjustsFontForContentSizeCategory = true
    }
  }
  
  override public var intrinsicContentSize: CGSize {
    switch self.attributedText {
    case let .some(text):
      let w = self.frame.width
      let h: CGFloat = text.height(containerWidth: w)
      return CGSize(width: w, height: h)
    case .none:
      let w = self.frame.width
      let h: CGFloat = 2
      textView?.text = nil
      textView?.attributedText = nil
      return CGSize(width: w, height: h)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    configure()
  }
  
  /// set text in order to run invalidate to calculate auto layout
  ///
  /// - Parameter attributedText: text attributed
  public func setupText(_ attributedText: NSAttributedString?) {
    self.attributedText = attributedText
    invalidateIntrinsicContentSize()
  }
  
  /// set text where to set custom linkable word
  ///
  /// - Parameters:
  ///   - linkableText: what need to link
  ///   - color: color of link
  ///   - link: linkable word which will be found in linkble text
  public func setupLink(_ linkableText: String, with color: UIColor, link: String) {
    guard let attributedText = attributedText else {
      fatalError("attributedText is not set !!!")
    }
    
    let wholeText = attributedText.string
    
    guard let location = wholeText.range(of: linkableText) else {
      fatalError("linkableText is not found as substring")
    }
    
    let linkTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color]
    
    textView?.linkTextAttributes = linkTextAttributes
    
    let distance = wholeText.distance(from: wholeText.startIndex, to: location.lowerBound)
    
    let mutable =  NSMutableAttributedString()
    
    mutable.append(attributedText)
    
    mutable.addAttribute(.link,
                         value: link,
                         range: NSRange(location: distance,
                                        length: linkableText.count))
    
    self.attributedText = mutable
    self.textView?.attributedText = self.attributedText
    
    invalidateIntrinsicContentSize()
  }
  
  private func configure() {
    textView = UITextView(frame: CGRect.zero)
    textView?.delegate = self
    textView?.textContainerInset = UIEdgeInsets.zero
    textView?.textContainer.lineFragmentPadding = 0
    textView?.isScrollEnabled = false
    textView?.isEditable = false
  }
  
  @available(iOS 10.0, *)
  public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    
    onClick?(URL)
    
    return false
  }
}

extension UIView {
  func fillSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
      rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
      topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
      bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
  }
}


extension NSAttributedString {
  
  func height(containerWidth: CGFloat) -> CGFloat {
    let rect = self.boundingRect(with: CGSize.init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    return ceil(rect.size.height)
  }
  
  func width(containerHeight: CGFloat) -> CGFloat {
    let rect = self.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: containerHeight), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    return ceil(rect.size.width)
  }
}

