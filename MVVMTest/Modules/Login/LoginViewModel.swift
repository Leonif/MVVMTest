//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import Utils
import FBSDKLoginKit

enum LoginViewModelEvent {
  case error
  case cancel
}

protocol LoginViewModelInterface {
  var eventHandler: EventHandler<LoginViewModelEvent>? { get set }
  func loginFacebook()
}

protocol LoginCoordinatorOutput: class {
  func loginFinished()
}

class LoginViewModel: LoginViewModelInterface {
  
  weak var output: LoginCoordinatorOutput?
  var service: Bool = true
  var eventHandler: EventHandler<LoginViewModelEvent>?
  var manager: LoginManager!
  
  func loginFacebook() {
    if AccessToken.current != nil {
      output?.loginFinished()
      return
    }
    
    self.manager.logIn(permissions: ["email"], from: nil) { (result, error) in
      guard let loginResult = result, error == nil else {
        self.eventHandler?(.error)
        return
      }
      
      if loginResult.isCancelled {
        self.eventHandler?(.cancel)
      } else {
        self.output?.loginFinished()
      }
    }
  }
}
