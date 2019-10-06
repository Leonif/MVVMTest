//
// Created by Leonid Nifantyev on 10/5/19.
// Copyright (c) 2019 Genesis. All rights reserved.
//

import UIKit

class CollectionHelper: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  
  var viewModel: InterestsDataSource!
  
  var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.register(InterestCell.self)
    }
  }
  var layout: UICollectionViewFlowLayout! {
    didSet {
      let width = UIScreen.main.bounds.width / 3
      layout.itemSize = CGSize(width: width, height: width)
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
    }
  }
  
  func reload() {
    collectionView.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.interestsCount()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = viewModel.getItem(for: indexPath.row)
    let cell: InterestCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.config(imageUrl: item.img.safe, title: item.title, color: item.color, isSelected: item.isSelected)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.selectedItem(for: indexPath.row)
    reload()
  }
}
