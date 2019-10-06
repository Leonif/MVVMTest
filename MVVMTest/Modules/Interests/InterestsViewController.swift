//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {
  private var titleLabel: UILabel!
  private var subtitleLabel: UILabel!
  private var collectionView: UICollectionView!
  private var layout: UICollectionViewFlowLayout!
  var collectionHelper: CollectionHelper?
  
  var viewModel: InterestsViewModelInterface! {
    didSet {
      viewModel.eventHandler = { [weak self] states in
        switch states {
        case .fetched:
          self?.collectionHelper?.reload()
        case .error:
          self?.showError()
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTitle()
    setupSubtitle()
    setupCollectionView()
    viewModel.fetch()
    decorate()
  }
  
  private func setupTitle() {
    self.titleLabel = UILabel(frame: CGRect.zero)
    self.view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
      titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
      titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
    ])
  }
  
  private func setupSubtitle() {
    self.subtitleLabel = UILabel(frame: CGRect.zero)
    self.view.addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
      subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
      subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
    ])
  }
  func setupCollectionView() {
    self.layout = UICollectionViewFlowLayout()
    self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
    
    collectionHelper?.collectionView = collectionView
    collectionHelper?.layout = layout
    
    self.view.addSubview(collectionView)
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false
  
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 32),
      collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
  
  private func decorate() {
    self.view.backgroundColor = .nero
    self.titleLabel.textAlignment = .center
    self.titleLabel.text = "Choose interests"
    self.titleLabel.textColor = .white
    self.titleLabel.font = UIFont.systemFont(ofSize: 32)
    self.subtitleLabel.textAlignment = .center
    self.subtitleLabel.text = "Choose 5 or more that you like in order to get proper recommendations"
    self.subtitleLabel.numberOfLines = 0
    self.subtitleLabel.textColor = .white
    self.subtitleLabel.font = UIFont.systemFont(ofSize: 20)
    self.collectionView.backgroundColor = .clear
  }
  
  func showError() {
    self.alert(message: "Something went wrong", okAction: { [weak self] in
      self?.viewModel.back()
    })
  }
}
