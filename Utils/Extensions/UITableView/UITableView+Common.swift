//
//  UITableView+Common.swift
//  NurKZ
//
//

import UIKit

extension UITableView {
  func reloadAllRows(in section: Int,
                     withAnimation animation: UITableView.RowAnimation) {
    let numberOfRowsInSection = numberOfRows(inSection: section)
    let indexPathes = (0..<numberOfRowsInSection)
      .map { IndexPath(row: $0, section: section) }
    reloadRows(at: indexPathes, with: animation)
  }
}

extension UITableView {
  func update(_ updateClosure: (UITableView) -> Void,
              completion: ((Bool) -> Void)? = nil) {
    if #available(iOS 11.0, *) {
      performBatchUpdates({
        updateClosure(self)
      }) { completed in
        completion?(completed)
      }
    } else {
      CATransaction.begin()
      beginUpdates()
      CATransaction.setCompletionBlock {
        completion?(true)
      }
      updateClosure(self)
      endUpdates()
      CATransaction.commit()
    }
  }
}
