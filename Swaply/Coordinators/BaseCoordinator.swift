import UIKit

class BaseCoordinator: Coordinator {

    // MARK: - Internal Properties
    var navigationController: UINavigationController?

    // MARK: - Initializers
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    // MARK: - Internal Methods
    func start() { }
}
