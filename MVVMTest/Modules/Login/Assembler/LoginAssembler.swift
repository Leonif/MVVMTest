//
// Created by Leonid Nifantyev on 10/5/19.
//

import Utils
import UIKit
import FBSDKLoginKit

enum LoginAssembler {
    static func makeLoginModule() -> Module<LoginViewModel> {
        let viewModel = LoginViewModel(loginManager: LoginManager())
        let viewController = LoginViewController(viewModel: viewModel)
        
        return (viewController, viewModel)
    }
}
