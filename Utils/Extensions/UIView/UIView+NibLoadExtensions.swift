//
//  UIView+Extensions.swift
//  NurKZ
//
//  Created by Nifantyev on 12/28/18.
//

import UIKit

open class LoadableView: UIView {
  
  public var loadedNibView: UIView?
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.loadedNibView = fromNib()
    self.nibDidLoad()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadedNibView = fromNib()
    self.nibDidLoad()
  }
  
  open func nibDidLoad() { }
  
}

public extension UIView {
  @discardableResult
  func fromNib<T: UIView>(withName name: String?) -> T? {
    guard let name = name,
          let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? T else {
      return nil
    }
    
    
    
    fitted(view: view)
    return view
  }
  
  @discardableResult
  func fromNib<T: UIView>() -> T? {
    let name = String(describing: type(of: self))
    return fromNib(withName: name)
  }
  
  func fitted(view: UIView) {
    self.addSubview(view)
    
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight];
  }
}