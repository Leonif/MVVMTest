//
//  InterestsViewModel.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//  Copyright © 2019 Genesis. All rights reserved.
//

import Utils

enum InterestsViewModelEvent {
  case error
}

protocol InteresrsViewModelInterface {
  var eventHandler: EventHandler<InterestsViewModelEvent>? { get set }
  func fetch()
}


class InterestsViewModel: InteresrsViewModelInterface {
  
  var eventHandler: EventHandler<InterestsViewModelEvent>? = nil
  private var coredataService: Bool = false
  
  func fetch() {
    if coredataService {
      debugPrint("Interests Fetched")
    } else {
      eventHandler?(.error)
    }
  }
  
}
