//
//  SceneDelegate.swift
//  Swaply
//
//  Created by Владислав Абушенко on 31.03.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = AppColors.backgroundPrimary
        window.rootViewController = SplashViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

    func showMain() {
        let navigationController = UINavigationController()

        rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator?.start()

        window?.rootViewController = navigationController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
