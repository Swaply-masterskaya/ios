import UIKit

final class SplashCoordinator: BaseCoordinator {

    // MARK: - Internal Properties
    var onFinish: (() -> Void)?

    // MARK: - Internal Methods
    override func start() {
        viewController = SplashViewController(coordinator: self)
    }

    override func finish() {
        onFinish?()
    }
}
