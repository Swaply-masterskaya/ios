import UIKit

class BaseCoordinator: Coordinator {

    var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func start() { }
}
