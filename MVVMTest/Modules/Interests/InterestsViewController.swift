//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {
  
  var viewModel: InteresrsViewModelInterface!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .yellow
    
    viewModel.eventHandler = { [weak self] states in
      switch states {
      case .error:
        self?.showError()
      }
    }
    
    viewModel.fetch()
  }
  
  func showError() {
    self.alert(message: "Something went wrong")
  }
}
