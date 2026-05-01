import UIKit

final class SplashCoordinator: BaseCoordinator {

    // MARK: - Private Properties
    private(set) lazy var viewController = SplashViewController(coordinator: self)

    // MARK: - Internal Properties
    var onFinish: (() -> Void)?

    // MARK: - Internal Methods
    override func start() {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func finish() {
        onFinish?()
    }
}
