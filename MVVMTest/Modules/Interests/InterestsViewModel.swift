//
//  InterestsViewModel.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//  Copyright © 2019 Genesis. All rights reserved.
//

import Utils
import UIKit

enum InterestsViewModelEvent {
  case fetched
  case error
}


struct InterestItem {
  var img: String
  var title: String
  var color: UIColor
  var isSelected: Bool
}

protocol InterestsViewModelInterface {
  var eventHandler: EventHandler<InterestsViewModelEvent>? { get set }
  func fetch()
  func back()
  func interestsCount() -> Int
  func getItem(for index: Int) -> InterestItem
  func selectedItem(for index: Int)
}

protocol InterestsCoordinatorOutput: class {
  func interestFinished()
}

class InterestsViewModel: InterestsViewModelInterface {
  weak var output: InterestsCoordinatorOutput?
  private var interests: [InterestItem] = [
    InterestItem(img: "", title: "Art & Design", color: UIColor.red, isSelected: false),
    InterestItem(img: "", title: "Auto & Vehicle", color: UIColor.yellow, isSelected: false),
    InterestItem(img: "", title: "Beauty", color: UIColor.green, isSelected: false),
    InterestItem(img: "", title: "Art & Design", color: UIColor.systemPink, isSelected: false),
    InterestItem(img: "", title: "Auto & Vehicle", color: UIColor.brown, isSelected: false),
  ]
  
  var eventHandler: EventHandler<InterestsViewModelEvent>? = nil
  private var coredataService: Bool = true
  
  func fetch() {
    if coredataService {
      debugPrint("Interests Fetched")
      eventHandler?(.fetched)
    } else {
      eventHandler?(.error)
      
    }
  }
  
  func back() {
    output?.interestFinished()
  }
  
  func interestsCount() -> Int {
    return interests.count
  }
  
  func getItem(for index: Int) -> InterestItem {
    return interests[index]
  }
  
  func selectedItem(for index: Int) {
    interests[index].isSelected.toggle()
  }
}
