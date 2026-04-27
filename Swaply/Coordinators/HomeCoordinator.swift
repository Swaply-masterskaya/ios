import UIKit

final class HomeCoordinator: BaseCoordinator {

    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .red
        navigationController?.setViewControllers([vc], animated: false)
    }
}
