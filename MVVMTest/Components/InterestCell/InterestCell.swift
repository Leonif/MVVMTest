//
//  InterestCell.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//  Copyright © 2019 Genesis. All rights reserved.
//

import Utils
import UIKit

class InterestCell: UICollectionViewCell, NibLoadableReusable {
  
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var containerView: UIView!
  @IBOutlet weak private var tickImage: UIImageView!
  
  func config(title: String, color: UIColor, isSelected: Bool) {
    titleLabel.text = title
    containerView.backgroundColor = color
    tickImage.isHidden = !isSelected
  }
  
}
