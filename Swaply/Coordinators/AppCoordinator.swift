import UIKit

final class AppCoordinator: BaseCoordinator {

    // MARK: - Private Properties
    private let window: UIWindow
    private var splashCoordinator: SplashCoordinator?

    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    // MARK: - Internal Methods
    override func start() {
        showSplash()
        window.makeKeyAndVisible()
    }

    // MARK: - Private Methods
    private func showSplash() {
        let splashCoordinator = SplashCoordinator()
        splashCoordinator.onFinish = { [weak self] in
            // TODO: - Сделать выбор флоу авторизации или мейн
            self?.showMain()
        }
        splashCoordinator.start()
        self.splashCoordinator = splashCoordinator
        window.rootViewController = splashCoordinator.viewController
    }

    private func showMain() {
        splashCoordinator = nil
        let tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator.start()
        window.rootViewController = tabBarCoordinator.tabBarController
    }
}
