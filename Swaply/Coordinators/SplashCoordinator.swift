import UIKit

final class SplashCoordinator: BaseCoordinator {

    var onFinish: (() -> Void)?

    private(set) lazy var viewController = SplashViewController(coordinator: self)

    override func start() {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func finish() {
        onFinish?()
    }
}
