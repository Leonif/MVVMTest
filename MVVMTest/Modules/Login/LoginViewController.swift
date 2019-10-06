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
  
  private var logoImage: UIImageView!
  private var titleLabel: UILabel!
  private var subtitleLabel: UILabel!
  private var loginButton: UIButton!
  
  var viewModel: LoginViewModelInterface! {
    didSet {
      self.viewModel.eventHandler = { [weak self] states in
        switch states {
        case .error:
          self?.showError()
        case .cancel:
          self?.show(info: "User cancelled login")
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavigationBar()
    self.view.backgroundColor = .nero
    self.setupButton()
    self.setupSubtitle()
    self.setupTitle()
    self.setupIcon()
    
  }
  
  private func setupNavigationBar() {
    let nav = self.navigationController?.navigationBar
    nav?.shadowImage = UIImage()
    nav?.setBackgroundImage(UIImage(), for: .default)
    nav?.isTranslucent = true
    nav?.barTintColor = .clear
    nav?.backgroundColor = .clear
  }
  
  private func setupIcon() {
    self.logoImage = UIImageView(image:UIImage(named: "logo"))
    self.logoImage.contentMode = .scaleAspectFill
    self.view.addSubview(logoImage)
    logoImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      logoImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -32),
      logoImage.heightAnchor.constraint(equalToConstant: 60),
      logoImage.widthAnchor.constraint(equalToConstant: 60),
    ])
  }
  
  private func setupTitle() {
    self.titleLabel = UILabel(frame: CGRect.zero)
    self.titleLabel.textAlignment = .center
    self.titleLabel.text = "Welcome to"
    self.titleLabel.textColor = .white
    self.titleLabel.font = UIFont.systemFont(ofSize: 32)
    self.view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
      titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
      titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -16),
    ])
  }
  
  private func setupSubtitle() {
    self.subtitleLabel = UILabel(frame: CGRect.zero)
    self.subtitleLabel.textAlignment = .center
    self.subtitleLabel.text = "SOCIAL MEDIA broadcaster"
    self.subtitleLabel.textColor = .white
    self.subtitleLabel.font = UIFont.systemFont(ofSize: 20)
    self.view.addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
      subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
      subtitleLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -70),
    ])
  }
  
  private func setupButton() {
    self.loginButton = UIButton(frame: CGRect.zero)
    self.loginButton.setTitle("Continue with Facebook", for: .normal)
    self.loginButton.backgroundColor = .steelBlue
    self.view.addSubview(loginButton)
  
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
      loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
      loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      loginButton.heightAnchor.constraint(equalToConstant: 60),
    ])
    
    loginButton.layer.cornerRadius = 30
    
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
    self.alert(title: "App", message: info)
  }
}