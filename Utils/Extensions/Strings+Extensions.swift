//
// Created by Nifantyev on 2019-04-29.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import Foundation


public extension String {
  var int: Int {
    return Int(self)!
  }
  
  var timeStamp: TimeStamp {
    return TimeStamp(self)!
  }
}

public extension String {
  var attributedString: NSAttributedString {
    return NSAttributedString(string: self)
  }
}

public extension String {
  var double: Double {
    return Double(self)!
  }
}