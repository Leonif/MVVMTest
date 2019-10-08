//
//  UIViewController+Common.swift
//  NurKZ
//
//

import UIKit

public extension UIViewController {
  func navigated<T: UINavigationController>(_ navigationControllerClass: T.Type) -> T {
    return T(rootViewController: self)
  }
}

//public extension UIViewController {
//  func setStatusBarStyle(_ style: UIStatusBarStyle) {
//
//    if view.window?.windowScene?.statusBarManager?.statusBarStyle {
////    if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//      statusBar.backgroundColor = style == .lightContent ? UIColor.clear : .clear
//      statusBar.setValue(style == .lightContent ? UIColor.white : .black, forKey: "foregroundColor")
//    }
//  }
//}
