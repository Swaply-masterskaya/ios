import UIKit

final class ProfileCoordinator: BaseCoordinator {

    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .cyan
        navigationController?.setViewControllers([vc], animated: false)
    }
}
