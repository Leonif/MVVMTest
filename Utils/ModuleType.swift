//
//  ModuleType.swift
//  NurKZ
//
//  Created by Nifantyev on 3/21/19.
//

import UIKit

//public typealias Module<Presenter> = (view: UIViewController, presenter: Presenter)
public typealias Module<ViewModel> = (view: UIViewController, viewModel: ViewModel)
