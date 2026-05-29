import UIKit

final class ProjectsCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        navigationController?.delegate = self

        viewController = ViewController(coordinator: self)

        guard let viewController else { return }

        viewController.view.backgroundColor = .yellow
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
