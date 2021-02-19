//
//  SceneDelegate.swift
//  MVVMTest
//
//  Created by Leonid Nifantyev on 10/5/19.
//

import UIKit
import DataLayer
import FBSDKLoginKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  var rootController: UINavigationController?
  
  private lazy var applicationCoordinator: CoordinatorInterface = makeCoordinator()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    self.rootController = makeRootViewController(with: scene)
    self.applicationCoordinator.start()
  }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

  
  private func makeRootViewController(with scene: UIScene) -> UINavigationController? {
    guard let windowScene = (scene as? UIWindowScene) else { return .none}
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    window?.makeKeyAndVisible()
    return self.window?.rootViewController as? UINavigationController
  }
  
  private func makeCoordinator() -> CoordinatorInterface {
    return AppCoordinator(router: Router(rootViewController: rootController!))
  }

}
