//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {
  
  var viewModel: InterestsViewModelInterface!
  
  private var collectionView: UICollectionView!
  private var layout: UICollectionViewFlowLayout!
  var collectionHelper: CollectionHelper?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .yellow
    setupCollectionView()
    
    viewModel.eventHandler = { [weak self] states in
      switch states {
      case .fetched:
        self?.collectionHelper?.reload()
      case .error:
        self?.showError()
      }
    }
    viewModel.fetch()
  }
  
  func setupCollectionView() {
    self.layout = UICollectionViewFlowLayout()
    self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
    
    collectionHelper?.collectionView = collectionView
    collectionHelper?.layout = layout
    collectionHelper?.viewModel = viewModel
    
    
    self.view.addSubview(collectionView)
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    self.collectionView.backgroundColor = .red
  
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
  
  func showError() {
    self.alert(message: "Something went wrong", okAction: { [weak self] in
      self?.viewModel.back()
    })
  }
}
