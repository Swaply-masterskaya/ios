import UIKit

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private var splashCoordinator: SplashCoordinator?

    // MARK: - Initializers

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Public Methods
    
    func start() {
        showSplash()
        window.makeKeyAndVisible()
    }

    private func showSplash() {
        let splashCoordinator = SplashCoordinator()
        self.splashCoordinator = splashCoordinator
        splashCoordinator.onFinish = { [weak self] in
            self?.showMain()
        }
        window.rootViewController = splashCoordinator.viewController
        splashCoordinator.start()
    }

    private func showMain() {
        let tabBarCoordinator = TabBarCoordinator()
        window.rootViewController = tabBarCoordinator.tabBarController
        tabBarCoordinator.start()
    }
}
