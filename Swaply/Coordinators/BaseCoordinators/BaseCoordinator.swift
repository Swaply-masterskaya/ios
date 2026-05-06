import UIKit

class BaseCoordinator: NSObject, Coordinator {

    // MARK: - Internal Properties
    var navigationController: UINavigationController?
    var viewController: BaseCoordinatingController?
    var childCoordinators = [Coordinator]()

    // MARK: - Initializers
    init(navigationController: UINavigationController? = nil, viewController: BaseCoordinatingController? = nil) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    // MARK: - Internal Methods
    func start() { }

    func finish() { }

    func push() { }

    func pop() { }
}

extension BaseCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromVC) else { return }

        if let child = childCoordinators.first(where: { $0.viewController === fromVC }) {
            removeChild(child)
        }
    }
}
