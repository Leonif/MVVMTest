import UIKit

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}

extension UIViewController: StoryboardIdentifiable {
  private class func instantiateViewController<T: UIViewController>(from storyBoard: UIStoryboard) -> T {
    debugPrint(storyboardIdentifier)
    guard let viewController = storyBoard.instantiateViewController(withIdentifier: storyboardIdentifier) as? T else {
      fatalError("\(#function) Couldn't instantiate view controller with identifier \(storyboardIdentifier) ")
    }
    return viewController
  }
  
  public class func initFromStoryboard() -> Self {
    let storyBoard = UIStoryboard(name: storyboardIdentifier, bundle: nil)
    return instantiateViewController(from: storyBoard)
  }
}

