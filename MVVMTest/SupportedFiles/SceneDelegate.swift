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

    private lazy var applicationCoordinator: CoordinatorInterface = makeCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        configure(scene)
        applicationCoordinator.start()
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
    
    private func makeCoordinator() -> CoordinatorInterface {
        guard let window = window else { fatalError("window is not created") }
        let router = Router(window: window)
        return AppCoordinator(router: router)
    }
    
    private func configure(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
    }
    
}
