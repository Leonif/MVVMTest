//
//  ViewController.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//  Copyright © 2019 Genesis. All rights reserved.
//

import UIKit
import Utils

class LoginViewController: UIViewController {
  
  private var loginButton: UIButton!
  var viewModel: LoginViewModelInterface!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .red
    
    self.viewModel.eventHandler = { [weak self] states in
      switch states {
      case .error:
        self?.showError()
      case .cancel:
        self?.show(info: "User canclled login")
      }
    }
    self.setupButton()
  }
  
  private func setupButton() {
    self.loginButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 50)))
    self.loginButton.setTitle("Login", for: .normal)
    self.view.addSubview(loginButton)
    loginButton.center = self.view.center
    
    self.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
  }
  
  @objc
  func loginTapped() {
    viewModel.loginFacebook()
  }
  
  private func showError() {
    self.alert(message: "Something went wrong")
  }
  
  private func show(info: String) {
    self.alert(message: info)
  }
}

