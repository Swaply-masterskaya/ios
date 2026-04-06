//
//  Coordinator.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

// не уверен что я должен создавать координатор, но пока свой использую, а дальше уже посмотрим как в проекте будет все

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = MainTabBarController()
        navigationController.setViewControllers([tabBarController], animated: false)
        navigationController.isNavigationBarHidden = true
    }
}
