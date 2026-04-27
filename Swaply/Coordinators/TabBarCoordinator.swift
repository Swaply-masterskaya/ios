import UIKit

final class TabBarCoordinator: BaseCoordinator {

    let tabBarController = MainTabBarController()

    var childCoordinators: [Coordinator] = []

    override func start() {
        childCoordinators = [
            HomeCoordinator(navigationController: UINavigationController()),
            LikesCoordinator(navigationController: UINavigationController()),
            ProjectsCoordinator(navigationController: UINavigationController()),
            ChatsCoordinator(navigationController: UINavigationController()),
            ProfileCoordinator(navigationController: UINavigationController())
        ]
        childCoordinators.forEach { $0.start() }

        tabBarController.coordinator = self
        tabBarController.viewControllers = childCoordinators.compactMap { $0.navigationController }
    }
}
