import UIKit

final class ChatsCoordinator: TabCoordinator {
    
    var navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .green
        navigationController.setViewControllers([vc], animated: false)
    }
}
