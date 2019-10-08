//
//  UINavigationController+Common.swift
//  NurKZ
//
//
//

import UIKit

public struct ln_NavBarButtonParams {
  public var title: String?
  public var titleColor: UIColor?
  public var font: UIFont?
  public var icon: UIImage?
  public var selector: Selector
  public var side: ButtonSide
  public var width: CGFloat
  
  public init(title: String? = nil, titleColor: UIColor? = .none,
              icon: UIImage? = nil, selector: Selector, side: ButtonSide, width: CGFloat = 40) {
    self.icon = icon
    self.selector = selector
    self.side = side
    self.title = title
    self.titleColor = titleColor
    self.width = width
  }
}

public enum ButtonSide {
  case left
  case right
}

public protocol NavigationItemable {}
public extension NavigationItemable where Self: UIViewController {
  
  func setBackButton(image: UIImage, color: UIColor) {
    // set main controller row below in order to remove button title
    // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    let yourBackImage = image
    self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    navigationController?.navigationBar.tintColor = color
  }
  
  func removeBackButton() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: .none, style: .plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
  }

  @discardableResult
  func appendNavBarButtons(with params: [ln_NavBarButtonParams], spacing: CGFloat = 2) -> (left: [UIButton], right: [UIButton]) {
    var leftButtons: [UIButton] = []
    var rightButtons: [UIButton] = []
    
    params.forEach { param in
      let btn = UIButton(type: .custom)
      btn.frame.size.width = param.width
      
      switch param.title {
      case let .some(title):
        btn.setTitle(title, for: .normal)
      default: break
      }
  
      switch param.titleColor {
      case let .some(color):
        btn.setTitleColor(color, for: .normal)
      default: break
      }
  
      switch param.icon {
      case let .some(icon):
        btn.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
      default: break
      }
      
      btn.addTarget(self, action: param.selector, for: .touchUpInside)
      
      switch param.side {
      case .left: leftButtons.append(btn)
      case .right: rightButtons.append(btn)
      }
    }
    
    if !leftButtons.isEmpty {
      let leftStackView = UIStackView(arrangedSubviews: leftButtons)
      leftStackView.distribution = .equalCentering
      leftStackView.axis = .horizontal
      leftStackView.alignment = UIStackView.Alignment.fill
      leftStackView.spacing = spacing
      let stackWidth = params.filter { $0.side == .left }.reduce(0) { $0 + $1.width }
      self.addButtons(with: leftStackView, width: stackWidth, into: .left)
    }
    
    if !rightButtons.isEmpty {
      let rightStackView = UIStackView(arrangedSubviews: rightButtons)
      rightStackView.distribution = .equalSpacing
      rightStackView.axis = .horizontal
      rightStackView.alignment = UIStackView.Alignment.fill
      rightStackView.spacing = spacing
      let stackWidth = params.filter { $0.side == .right }.reduce(0) { $0 + $1.width}//buttonWidth * rightButtons.count.cgFloat
      self.addButtons(with: rightStackView, width: stackWidth, into: .right)
    }
    
    return (leftButtons, rightButtons)
  }
  
  func addButtons(with stackView: UIStackView, width: CGFloat, into direction: ButtonSide) {
    let stack = prepareStack(with: stackView, width: width)
    switch direction {
    case .right: self.navigationItem.rightBarButtonItem = stack
    case .left:
      navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      self.navigationItem.leftBarButtonItem  = stack
    }
  }
  
  private func prepareStack(with stackView: UIStackView, width: CGFloat) -> UIBarButtonItem {
    // container need for ios 10.0 as stack view is not shown as CustomView for nav bar button
    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 30))
    containerView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
    ])
    return UIBarButtonItem(customView: containerView)
  }
}



public extension UINavigationBar {
  func setStyle(font: UIFont, color: UIColor = .white) {
    let attrs: [NSAttributedString.Key: Any] = [
      .foregroundColor: color,
      .font: font
    ]
    self.titleTextAttributes = attrs
  }
  
  func setBackgroundColor(color: UIColor) {
    self.barTintColor = color
    self.backgroundColor = color
    self.setBackgroundImage(UIImage.fromColor(color: color), for: .default)
    self.isTranslucent = true
    self.barTintColor = color
    self.backgroundColor = color
  }
}