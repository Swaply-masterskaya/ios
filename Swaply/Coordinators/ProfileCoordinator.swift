import UIKit

final class ProfileCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        viewController = ViewController(coordinator: self)

        guard let viewController else { return }

        viewController.view.backgroundColor = .cyan
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
