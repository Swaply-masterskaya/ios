import UIKit

final class ProjectsCoordinator: TabCoordinator {

    var navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .yellow
        navigationController.setViewControllers([vc], animated: false)
    }
}

