import UIKit

final class TabBarCoordinator: BaseCoordinator {

    // MARK: - Internal Properties
    lazy var tabBarController = MainTabBarController(coordinator: self)

    // MARK: - Internal Methods
    override func start() {
        childCoordinators = [
            HomeCoordinator(navigationController: UINavigationController()),
            LikesCoordinator(navigationController: UINavigationController()),
            ProjectsCoordinator(navigationController: UINavigationController()),
            ChatsCoordinator(navigationController: UINavigationController()),
            ProfileCoordinator(navigationController: UINavigationController())
        ]

        childCoordinators.forEach { $0.start() }

        tabBarController.viewControllers = childCoordinators.compactMap { $0.navigationController }
    }
}
