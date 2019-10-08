//
//  View+BlurExtension.swift
//  FMBlurable
//
//  Created by SIMON_NON_ADMIN on 18/09/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//
// Thanks to romainmenke (https://twitter.com/romainmenke) for hint on a larger sample...

import UIKit

public extension UIView {
  func applyBlur(level: CGFloat, duration: TimeInterval, completed: (() -> Void)? = .none) {
    let context = CIContext(options: nil)
    self.makeBlurredImage(with: level, context: context, completed: { processedImage in
      let imageView = UIImageView(image: processedImage)
      imageView.tag = 0902
      imageView.alpha = 0
      imageView.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: self.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      ])
      
      UIView.animate(withDuration: duration) {
        imageView.alpha = 1
        completed?()
      }
    })
  }
  
  
  func removeBlur(duration: TimeInterval, completed: (() -> Void)? = .none) {
    let imageView: UIImageView = self.subviews.first(where: { $0.tag == 0902 }) as! UIImageView
    UIView.animate(withDuration: duration) {
      imageView.alpha = 0
      completed?()
    }
  }
  
  private func makeBlurredImage(with level: CGFloat, context: CIContext, completed: @escaping (UIImage) -> Void) {
    // screen shot
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 1)
    self.layer.render(in: UIGraphicsGetCurrentContext()!)
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
  
    let beginImage = CIImage(image: resultImage)
  
    // make blur
    let blurFilter = CIFilter(name: "CIGaussianBlur")!
    blurFilter.setValue(beginImage, forKey: kCIInputImageKey)
    blurFilter.setValue(level, forKey: kCIInputRadiusKey)
  
    // extend source image na apply blur to it
    let cropFilter = CIFilter(name: "CICrop")!
    cropFilter.setValue(blurFilter.outputImage, forKey: kCIInputImageKey)
    cropFilter.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
  
    let output = cropFilter.outputImage!
    DispatchQueue.global(qos: .userInteractive).async {
      let extent = output.extent
      let cgImg = context.createCGImage(output, from: extent)!
      let processedImage = UIImage(cgImage: cgImg)
    
      DispatchQueue.main.async {  completed(processedImage)   }
    }
  }
}