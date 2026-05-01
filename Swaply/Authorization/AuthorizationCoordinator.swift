import UIKit

protocol AuthorizationCoordinatorProtocol: AnyObject {
    func finishFlow()
}

final class AuthorizationCoordinator: Coordinator, AuthorizationCoordinatorProtocol {

    // MARK: - Internal Properties
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var onFinish: (() -> Void)?

    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Internal Methods
    func start() {
        let viewModel = AuthorizationViewModel(coordinator: self)
        let vc = AuthorizationViewController(viewModel: viewModel)
        navigationController.setViewControllers([vc], animated: false)
    }

    func finishFlow() {
        onFinish?()
    }
}
