//
//  UICollectionView+Extensions.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//
import UIKit

public extension ReusableView where Self: UICollectionViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
public extension NibLoadableView where Self: UICollectionViewCell {
  static var nibName: String {
    return String(describing: self)
  }
}

public extension ReusableView where Self: UICollectionReusableView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

public extension NibLoadableView where Self: UICollectionReusableView {
  static var nibName: String {
    return String(describing: self)
  }
}

public extension UICollectionView {
  func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
  func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    return cell
  }
  
}

public extension UICollectionView {
  
  func register<T: UICollectionReusableView>(_: T.Type, kind: String) where T: ReusableView {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier:  T.reuseIdentifier)
  }
  
  func register<T: UICollectionReusableView>(_: T.Type, kind: String) where T: ReusableView, T: NibLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
  }
  
  
  func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind: String, for indexPath: IndexPath) -> T where T: ReusableView {
    guard let reusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue reusable view with identifier: \(T.reuseIdentifier)")
    }
    
    return reusableView
  }
}



public extension UICollectionViewFlowLayout {
  func selfSizingCells() {
    self.itemSize = UICollectionViewFlowLayout.sizeAutomatic
    self.estimatedItemSize = CGSize(width: 1, height: 1)
  }
  
  
}

public extension UICollectionViewFlowLayout {
  static var sizeAutomatic: CGSize {
    if #available(iOS 10.0, *) {
      return self.automaticSize
    } else {
      assertionFailure("OS lower than 10.0")
      return CGSize(width: 1, height: 50)
    }
  }
}