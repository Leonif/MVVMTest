//
//  InterestCell.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//

import Utils
import UIKit

class InterestCell: UICollectionViewCell, NibLoadableReusable {
  @IBOutlet weak private var icon: UIImageView!
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var containerView: UIView!
  @IBOutlet weak private var tickImage: UIImageView!
  
  func config(imageUrl: String, title: String, color: UIColor, isSelected: Bool) {
    icon.image = imageUrl.isEmpty ? UIImage(named: "pen") : UIImage(named: imageUrl)
    titleLabel.text = title
    containerView.backgroundColor = color
    tickImage.isHidden = !isSelected
  }
}
