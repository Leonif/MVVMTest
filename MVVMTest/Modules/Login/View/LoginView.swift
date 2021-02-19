//
//  LoginView.swift
//  MVVMTest
//
//  Created by Xcode user on 19.02.2021.
//  Copyright © 2021 Genesis. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    private var logoImage: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private(set) var loginButton: UIButton!
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    
    private func setup() {
        backgroundColor = .red
        self.setupButton()
        self.setupSubtitle()
        self.setupTitle()
        self.setupIcon()
        self.decorate()
        
        setNeedsUpdateConstraints()
    }
    
    private func setupIcon() {
      self.logoImage = UIImageView(image:UIImage(named: "logo"))
      self.logoImage.contentMode = .scaleAspectFill
      addSubview(logoImage)
      logoImage.translatesAutoresizingMaskIntoConstraints = false
      
    }
    
    private func setupTitle() {
      self.titleLabel = UILabel(frame: CGRect.zero)
      addSubview(titleLabel)
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      
    }
    
    private func setupSubtitle() {
      self.subtitleLabel = UILabel(frame: CGRect.zero)
      addSubview(subtitleLabel)
      subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
      
    }
    
    private func setupButton() {
      self.loginButton = UIButton(frame: CGRect.zero)
      addSubview(loginButton)
      loginButton.translatesAutoresizingMaskIntoConstraints = false
      
      
    }
    
    private func decorate() {
      backgroundColor = .nero
      loginButton.setTitle("Continue with Facebook", for: .normal)
      loginButton.backgroundColor = .steelBlue
      loginButton.layer.cornerRadius = 30
      titleLabel.text = "Welcome to"
      titleLabel.textAlignment = .center
      titleLabel.textColor = .white
      titleLabel.font = UIFont.systemFont(ofSize: 32)
      subtitleLabel.text = "SOCIAL MEDIA broadcaster"
      subtitleLabel.textAlignment = .center
      subtitleLabel.textColor = .white
      subtitleLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
          logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
          logoImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -32),
          logoImage.heightAnchor.constraint(equalToConstant: 60),
          logoImage.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
          titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
          titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
          titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
          subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
          subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
          subtitleLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -70),
        ])
        
        NSLayoutConstraint.activate([
          loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
          loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
          loginButton.centerYAnchor.constraint(equalTo: centerYAnchor),
          loginButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
