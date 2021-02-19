//
//  InterestsAssembler.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//

import Utils
import DataLayer

enum InterestsAssembler {
  static func makeInterestModule() -> Module<InterestsViewModel> {
    let viewModel = InterestsViewModel()
    let viewController = InterestsViewController(viewModel: viewModel)
    
    viewModel.persistenceProvider = DataProviderFactory().assemble()
    
    return (viewController, viewModel)
  }
}
