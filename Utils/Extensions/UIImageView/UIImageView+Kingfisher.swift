//
//  UIImageView+Kingfisher.swift
//  NurKZ
//

//

//import Kingfisher
//
//extension UIImageView {
//  func loadImg(fromUrl url: String, placeholder: UIImage? = nil) {
//    guard let url = URL(string: url) else {
//      self.image = placeholder
//      return
//    }
//
//    kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.5))])
//  }
//
//  func cancelImgLoadTask() {
//    kf.cancelDownloadTask()
//  }
//
//
//  func loadImg2(fromUrl url: String, placeholder: UIImage? = nil, didFinish: ((UIImage?) -> Void)? = nil) {
//    guard let url = URL(string: url) else {
//      self.image = placeholder
//      return
//    }
//    kf.indicatorType = .activity
//    kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.5))], progressBlock: nil) { (image, error, _, _) in
//
//      didFinish?(error == nil ? image : nil)
//    }
//  }
//
//
//  func reduce() {
//    kf.placeholder?.remove(from: self)
//  }
//}
