import UIKit

final class LikesCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        viewController = ViewController(coordinator: self)

        guard let viewController else { return }

        viewController.view.backgroundColor = .orange
        navigationController?.setViewControllers([viewController], animated: false)
    }

    override func push() {
        // Место для пуша нового координатора
        // Обязательно передайте навигационный контроллер этого координатора

        // Демонстрационный пример
        // let childCoordinator = ChildCoordinator(navigationController: navigationController)
        // childCoordinator.start()
        // addChild(childCoordinator)
    }
}
