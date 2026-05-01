import UIKit

final class LikesCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .orange
        navigationController?.setViewControllers([vc], animated: false)
    }
}
