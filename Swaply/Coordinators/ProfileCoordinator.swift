import UIKit

final class ProfileCoordinator: TabCoordinator {

    var navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .cyan
        navigationController.setViewControllers([vc], animated: false)
    }
}

