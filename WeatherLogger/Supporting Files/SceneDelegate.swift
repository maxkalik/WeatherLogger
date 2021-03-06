//
//  SceneDelegate.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/8/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController, persistenceManager: PersistenceManager.shared)
        coordinator?.start()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

