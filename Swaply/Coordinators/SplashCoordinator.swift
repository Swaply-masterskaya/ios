import UIKit

final class SplashCoordinator: Coordinator {

    var navigationController = UINavigationController()

    var onFinish: (() -> Void)?

    private(set) lazy var viewController = SplashViewController(coordinator: self)

    func start() {
        navigationController.pushViewController(viewController, animated: true)
    }

    func finish() {
        onFinish?()
    }
}
