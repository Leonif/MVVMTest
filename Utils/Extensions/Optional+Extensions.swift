//
// Created by Leonid Nifantyev on 9/12/19.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: Collection {
  var safe: Wrapped {
    switch self {
    case let .some(array):
      return array
    case .none:
      return [] as! Wrapped
    }
  }
}
