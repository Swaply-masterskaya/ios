import UIKit

final class HomeCoordinator: TabCoordinator {

    let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .red
        navigationController.setViewControllers([vc], animated: false)
    }
}
