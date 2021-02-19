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
    var eventHandler: EventHandler<LoginViewModelEvent>?
    let manager: LoginManager
    
    init(loginManager: LoginManager) {
        self.manager = loginManager
    }
    
    func loginFacebook() {
        if let token = AccessToken.current, !token.isExpired {
            output?.loginFinished()
            return
        }
        
        self.manager.logIn(permissions: ["email"], from: nil) { [weak self] (result, error) in
            guard let loginResult = result, error == nil else {
                self?.eventHandler?(.error)
                return
            }
            
            if loginResult.isCancelled {
                self?.eventHandler?(.cancel)
            } else {
                self?.output?.loginFinished()
            }
        }
    }
}
