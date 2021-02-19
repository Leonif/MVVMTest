//
//  InterestsView.swift
//  MVVMTest
//
//  Created by Xcode user on 19.02.2021.
//  Copyright © 2021 Genesis. All rights reserved.
//

import UIKit

class InterestsView: UIView {
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    let collectionHelper: CollectionHelper
    
    init(viewModel: InterestsDataSource) {
        collectionHelper = CollectionHelper()
        
        super.init(frame: .zero)
        
        collectionHelper.viewModel = viewModel
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    private func setup() {
        backgroundColor = .red
        setupTitle()
        setupSubtitle()
        setupCollectionView()
        decorate()
        setNeedsUpdateConstraints()
    }
    
    private func setupTitle() {
        self.titleLabel = UILabel(frame: CGRect.zero)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubtitle() {
        self.subtitleLabel = UILabel(frame: CGRect.zero)
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func setupCollectionView() {
        self.layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        
        collectionHelper.collectionView = collectionView
        collectionHelper.layout = layout
        
        addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 32),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func decorate() {
        backgroundColor = .nero
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
}

