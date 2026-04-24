import UIKit

final class LikesCoordinator: TabCoordinator {

    var navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .orange
        navigationController.setViewControllers([vc], animated: false)
    }
}
