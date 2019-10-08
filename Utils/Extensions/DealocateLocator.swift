//
//  DealocateLocator.swift
//  NurKZ
//
//  Created by Nifantyev on 12/26/18.
//

public protocol DeallocateLocator: class {}
public extension DeallocateLocator {
  func allocateMessage() {
    debugPrint("class \(String(describing: self)) allocated")
  }
  
  /// Place at deinit
  func deallocateMessage() {
    debugPrint("class \(String(describing: self)) deallocated")
  }
}
