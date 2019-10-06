//
//  InterestsAssembler.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//  Copyright © 2019 Genesis. All rights reserved.
//

import Utils
import DataLayer

enum InterestsAssembler {
  static func makeInterestModule() -> Module<InterestsViewModel> {
    let view = InterestsViewController()
    let viewModel = InterestsViewModel()
    viewModel.persistenceProvider = DataProviderFactory().assemble()
    view.viewModel = viewModel
    view.collectionHelper = CollectionHelper()
    return (view, viewModel)
  }
}
