import UIKit

final class TabBarCoordinator: Coordinator {

    let tabBarController = MainTabBarController()

    var childCoordinators: [TabCoordinator] = [
        HomeCoordinator(),
        LikesCoordinator(),
        ProjectsCoordinator(),
        ChatsCoordinator(),
        ProfileCoordinator()
    ]

    func start() {
        childCoordinators.forEach { $0.start() }

        tabBarController.viewControllers = childCoordinators.compactMap { $0.navigationController }
    }
}
