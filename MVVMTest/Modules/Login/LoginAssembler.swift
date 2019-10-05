//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import Utils
import UIKit


enum LoginAssembler {
  static func makeLoginModule() -> Module<LoginViewModel> {
    let view = LoginViewController()
    let viewModel = LoginViewModel()
    view.viewModel = viewModel
    return (view, viewModel)
  }
}
