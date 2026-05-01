import UIKit

final class ChatsCoordinator: BaseCoordinator {

    // MARK: - Internal Methods
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .green
        navigationController?.setViewControllers([vc], animated: false)
    }
}
