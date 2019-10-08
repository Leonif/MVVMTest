//
// Created by Leonid Nifantyev on 2019-06-28.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

public extension Error {
  var code: Int { return (self as NSError).code }
  var domain: String { return (self as NSError).domain }
}