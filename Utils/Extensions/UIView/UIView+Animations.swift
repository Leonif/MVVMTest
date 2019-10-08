//
// Created by Leonid Nifantyev on 2019-07-05.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

import UIKit

public extension UIView {
  private struct AnimationKey {
    static let Rotation = "rotation"
    static let Bounce = "bounce"
  }
  
  func startWiggle() {
    debugPrint("wiggle")
    let wiggleBounceY = 2.0
    let wiggleBounceDuration = 0.18
    let wiggleBounceDurationVariance = 0.025
    
    let wiggleRotateAngle = 0.02
    let wiggleRotateDuration = 0.14
    let wiggleRotateDurationVariance = 0.025

//    guard // If the view is already animating rotation or bounce, return
//      let keys = layer.animationKeys(),
//      keys.contains(AnimationKey.Rotation) == false,
//      keys.contains(AnimationKey.Bounce) == false
//      else {
//      return
//    }
    
    //Create rotation animation
    let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.values = [-wiggleRotateAngle, wiggleRotateAngle]
    rotationAnimation.autoreverses = true
    rotationAnimation.duration = randomize(interval: wiggleRotateDuration, withVariance: wiggleRotateDurationVariance)
    rotationAnimation.repeatCount = .infinity
    
    //Create bounce animation
    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
    bounceAnimation.values = [wiggleBounceY, 0]
    bounceAnimation.autoreverses = true
    bounceAnimation.duration = randomize(interval: wiggleBounceDuration, withVariance: wiggleBounceDurationVariance)
    bounceAnimation.repeatCount = .infinity
    
    //Apply animations to view
    UIView.animate(withDuration: 0) {
      self.layer.add(rotationAnimation, forKey: AnimationKey.Rotation)
      self.layer.add(bounceAnimation, forKey: AnimationKey.Bounce)
      self.transform = .identity
    }
  }
  
  func stopWiggle(){
    layer.removeAnimation(forKey: AnimationKey.Rotation)
    layer.removeAnimation(forKey: AnimationKey.Bounce)
  }
  
  // Utility
  
  private func randomize(interval: TimeInterval, withVariance variance: Double) -> Double{
    let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
    return interval + variance * random
  }
}


public extension UIView {
  func shake() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.1
    animation.repeatCount = 100
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2.0, y: self.center.y))
    layer.add(animation, forKey: "position")
  }
  
  func shake2(duration: CFTimeInterval = 0.7) {
    let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
    translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
    
    let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map { (degrees: Double) -> Double in
      let radians: Double = ( Double.pi * degrees) / 180.0
      return radians
    }
    
    let shakeGroup: CAAnimationGroup = CAAnimationGroup()
    shakeGroup.animations = [translation, rotation]
    shakeGroup.repeatCount = 100
    shakeGroup.duration = duration
    shakeGroup.autoreverses = true
    self.layer.add(shakeGroup, forKey: "shakeIt")
  }
}
