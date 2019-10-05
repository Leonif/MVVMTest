//
//  ViewController.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//  Copyright © 2019 Genesis. All rights reserved.
//

import UIKit

protocol LoginCoordinatorOutput: class {
  func loginTapped()
}

class LoginViewController: UIViewController {
  
  private var loginButton: UIButton!
  weak var output: LoginCoordinatorOutput?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .red
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
    output?.loginTapped()
  }
  
}

