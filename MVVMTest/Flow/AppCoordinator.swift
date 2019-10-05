//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import UIKit

protocol RouterInterface {
  func push(viewController: UIViewController)
  func setRootModule(viewController: UIViewController)
}


protocol CoordinatorInterface: class {
  func start()
//  func start(with option: DeepLinkOption?)
}


class Router: RouterInterface {
  
  var rootViewController: UINavigationController!
  
  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController
  }
  
  func push(viewController: UIViewController) {
    self.rootViewController.pushViewController(viewController, animated: true)
  }
  
  func setRootModule(viewController: UIViewController) {
    self.rootViewController?.setViewControllers([viewController], animated: false)
  }
}

class AppCoordinator: CoordinatorInterface {
  var router: RouterInterface?
  
  init(router: RouterInterface) {
    self.router = router
  }
  
  func start() {
    showLoginScreen()
  }
  
  private func showLoginScreen() {
    let view = LoginViewController()
    view.output = self
    router?.setRootModule(viewController: view)
  }
  
  private func showInterestsScreen() {
    let view = InterestsViewController()
//    view.output = self
    router?.push(viewController: view)
  }
  
}


extension AppCoordinator: LoginCoordinatorOutput {
  func loginTapped() {
    showInterestsScreen()
  }
}