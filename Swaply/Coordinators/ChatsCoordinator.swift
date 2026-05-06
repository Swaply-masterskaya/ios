import UIKit

final class ChatsCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        viewController = ViewController(coordinator: self)

        guard let viewController else { return }

        viewController.view.backgroundColor = .green
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
