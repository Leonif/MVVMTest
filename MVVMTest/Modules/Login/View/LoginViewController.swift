//
//  ViewController.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//

import UIKit
import Utils

class LoginViewController: UIViewController {
    
    let rootView = LoginView()
    var viewModel: LoginViewModelInterface
    
    convenience init(viewModel: LoginViewModelInterface) {
        self.init(viewModel: viewModel, nibName: .none, bundle: .none)
    }
    
    init(viewModel: LoginViewModelInterface, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.eventHandler = { [weak self] states in
            switch states {
            case .error:
                self?.showError()
            case .cancel:
                self?.show(info: "User cancelled login")
            }
        }
        
        rootView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        let nav = self.navigationController?.navigationBar
        nav?.shadowImage = UIImage()
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.isTranslucent = true
        nav?.barTintColor = .clear
        nav?.backgroundColor = .clear
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
