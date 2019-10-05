//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import Utils

enum LoginViewModelEvent {
  case error
}

protocol LoginViewModelInterface {
  var eventHandler: EventHandler<LoginViewModelEvent>? { get set }
  func loginFacebook()
  func onFinished()
}

protocol LoginCoordinatorOutput: class {
  func loginFinished()
}

class LoginViewModel: LoginViewModelInterface {
  
  weak var output: LoginCoordinatorOutput?
  var service: Bool = true
  var eventHandler: EventHandler<LoginViewModelEvent>?
  
  func loginFacebook() {
    if service {
      output?.loginFinished()
    } else {
      eventHandler?(.error)
    }
  }
  
  func onFinished() {
  
  }
}
