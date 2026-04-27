//
//  Coordinator.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

final class RootCoordinator: Coordinator {
    // MARK: - Private Properties
    private var isAuthorized: Bool {
        UserDefaults.standard.bool(forKey: "isAuthorized")
    }

    // MARK: - Public Properties

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods

    func start() {
        // Для проверки экрана авторизации раскоментите строчку ниже
//        UserDefaults.standard.set(false, forKey: "isAuthorized")
        if isAuthorized {
            showTabBar()
        } else {
            showAuthorization()
        }
    }

    private func showTabBar() {
        let tabBarController = MainTabBarController()
        navigationController.setViewControllers([tabBarController], animated: false)
        navigationController.isNavigationBarHidden = true
    }

    private func showAuthorization() {
        let coordinator = AuthorizationCoordinator(navigationController: navigationController)

        coordinator.onFinish = { [weak self] in
            self?.showTabBar()
        }

        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
