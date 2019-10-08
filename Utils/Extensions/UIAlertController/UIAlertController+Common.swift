//
//  UIAlertController+Common.swift
//  NurKZ
//
//

import UIKit

extension UIAlertController {
  func addNonActionableAction(withTitle title: String = "OK") {
    let action = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil)
    addAction(action)
  }
  
  func addActions(_ actions: UIAlertAction...) {
    actions.forEach(addAction(_:))
  }
}

public typealias AlertAction = () -> Void
public extension UIViewController {
  func alert(title: String? = "Error",
             message: String,
             okTitle: String? = "Ok",
             cancelTitle: String? = nil,
             okAction: AlertAction? = nil,
             cancelAction: AlertAction? = nil,
             completion: AlertAction? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
      okAction?()
    }))
    
    if let cancelAction = cancelAction {
      alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: { (action: UIAlertAction!) in
        cancelAction()
      }))
    }
    self.present(alert, animated: true, completion: completion)
  }
}


public extension UIViewController { // see extension for AppDelegate
  func showActionSheet(actionsTitles: [String], selection: (index: Int, color: UIColor)? = .none, backGround: UIColor, selectAction: @escaping (Int) -> Void) {
    let optionMenu = UIAlertController(title: "Select League season", message: .none, preferredStyle: .actionSheet)
    optionMenu.view.tintColor = .white
    
    for ( index, title ) in actionsTitles.enumerated() {
      let action = UIAlertAction(title: title, style: .default) { _ in
        selectAction(index)
      }
      action.setValue(UIColor.white, forKey: "titleTextColor")
      optionMenu.addAction(action)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    optionMenu.addAction(cancelAction)
    
    switch selection {
    case let .some(s):
      optionMenu.actions[s.index].setValue(s.color, forKey: "titleTextColor")
    default: break
    }
    
    
    if let firstSubview = optionMenu.view.subviews.first, let alertContentView = firstSubview.subviews.first {
      for view in alertContentView.subviews {
        view.backgroundColor = backGround
      }
    }
    self.present(optionMenu, animated: true, completion: nil)
  }
}


// insert it into AppDelegate

// -> didFinishLaunching
//if let cancelBackgroundViewType = NSClassFromString("_UIAlertControlleriOSActionSheetCancelBackgroundView") as? UIView.Type {
//  cancelBackgroundViewType.appearance().subviewsBackgroundColor = .charcoalGreyTwo
//}


// - > file AppDelegate
//fileprivate extension UIView {
//  private struct AssociatedKey {
//    static var subviewsBackgroundColor = "subviewsBackgroundColor"
//  }
//
//  @objc dynamic var subviewsBackgroundColor: UIColor? {
//    get {
//      return objc_getAssociatedObject(self, &AssociatedKey.subviewsBackgroundColor) as? UIColor
//    }
//
//    set {
//      objc_setAssociatedObject(self,
//        &AssociatedKey.subviewsBackgroundColor,
//        newValue,
//        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//      subviews.forEach { $0.backgroundColor = newValue }
//    }
//  }
//}