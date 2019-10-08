//
// Created by Leonid Nifantyev on 10/5/19.
//

import Utils
import UIKit
import FBSDKLoginKit


enum LoginAssembler {
  static func makeLoginModule() -> Module<LoginViewModel> {
    let view = LoginViewController()
    let viewModel = LoginViewModel()
    viewModel.manager = LoginManager()
    view.viewModel = viewModel
    return (view, viewModel)
  }
}
