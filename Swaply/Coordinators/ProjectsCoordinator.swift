import UIKit

final class ProjectsCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .yellow
        navigationController?.setViewControllers([vc], animated: false)
    }
}
